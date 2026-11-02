#!/usr/bin/env bash
# Build + smoke-test the static site image. This is the only proof that counts:
# it builds the real image, runs it, and sweeps every route / asset.
set -euo pipefail
cd "$(dirname "$0")"

TAG="alergen-site:local"
PORT="${PORT:-8099}"
NAME="alergen-site-test"

echo "==> build $TAG"
sudo docker build -q -t "$TAG" .
sudo docker rm -f "$NAME" >/dev/null 2>&1 || true
echo "==> run on :$PORT"
sudo docker run -d --name "$NAME" -p "$PORT:80" "$TAG" >/dev/null

for i in $(seq 1 20); do
  if curl -fsS -o /dev/null "http://127.0.0.1:$PORT/healthz"; then break; fi
  sleep 1
done

fail=0
check() { # path expected_code
  code=$(curl -s -o /tmp/alergen-body -w '%{http_code}' "http://127.0.0.1:$PORT$1")
  if [ "$code" = "$2" ]; then printf "  ok   %-28s %s\n" "$1" "$code"
  else printf "  FAIL %-28s got=%s want=%s\n" "$1" "$code" "$2"; fail=1; fi
}

echo "==> route sweep"
check / 200
check /index.html 200
check /healthz 200
check /robots.txt 200
check /sitemap.xml 200
check /favicon.svg 200
check /404.html 404   # internal-only error document (deliberate: no duplicate content)
check /images/hero-patch.webp 200
check /images/patch-atas.webp 200
check /images/patch-samping.webp 200
check /images/patch-miring.webp 200
check /images/detail-makro.webp 200
check /images/cta-gelap.webp 200
check /images/booklet-cover.webp 200
check /images/qr-booklet.png 200
check /dokumen/booklet-alergi-ringan.pdf 200
check /booklet 200
check /expo/ 200
check /expo/index.html 200
check /halaman-tidak-ada 404

echo "==> content assertions"
curl -fsS "http://127.0.0.1:$PORT/" > /tmp/alergen-index.html
python3 - <<'PY'
import sys
h = open('/tmp/alergen-index.html', encoding='utf-8').read()
need = ['<!DOCTYPE html>', '<html lang="id">', 'width=device-width',
        'Kit Diagnostik Alergi Berbasis Patch Transdermal',
        'Sepuluh jenis ekstrak alergen', 'Tim inventor', 'Junaidi Khotib',
        'PT Bio Farma', 'CD209', 'validasi klinis',
        'id="booklet"', 'Dari Gejala ke Toleransi',
        'dokumen/booklet-alergi-ringan.pdf',
        'rel="canonical"', 'application/ld+json', '[hidden] { display: none !important; }']
ban = ['Tablet sublingual', 'SLIT', 'Grand View', 'Panel alergen',
       'HPMC', 'Mordor', 'tablet.webp']
missing = [n for n in need if n not in h]
found = [b for b in ban if b in h]
print("  ok   html shell + content" if not missing and not found
      else f"  FAIL missing: {missing}; banned present: {found}")
sys.exit(1 if missing or found else 0)
PY

echo "==> expo prototype assertions"
curl -fsS "http://127.0.0.1:$PORT/expo/" > /tmp/alergen-expo.html
python3 - <<'PY'
import sys
h = open('/tmp/alergen-expo.html', encoding='utf-8').read()
need = ['<html lang="id">', 'width=device-width', 'noindex,nofollow',
        'Alergen Expo', 'Mode suara', 'Patch diagnostik Alergen',
        'IDS000011522', 'function respond', 'MIN_COV', 'Kuis singkat',
        'Panel tim', 'speechSynthesis', 'webkitSpeechRecognition', 'localStorage', 'window.__expo', 'splitClauses',
        'Booklet untuk dibawa pulang', 'dokumen/booklet-alergi-ringan.pdf']
ban = ['http://cdn', 'unpkg.com', 'cdn.jsdelivr.net']
missing = [n for n in need if n not in h]
found = [b for b in ban if b in h]
print("  ok   expo shell + engine" if not missing and not found
      else f"  FAIL missing: {missing}; banned present: {found}")
sys.exit(1 if missing or found else 0)
PY

echo "==> booklet pdf integrity"
for u in /dokumen/booklet-alergi-ringan.pdf /booklet; do
  curl -sI "http://127.0.0.1:$PORT$u" | tr -d '\r' > /tmp/alergen-pdf-head
  ct=$(awk -F': ' 'tolower($1)=="content-type"{print $2}' /tmp/alergen-pdf-head)
  sz=$(curl -s -o /tmp/alergen-booklet.pdf -w '%{size_download}' "http://127.0.0.1:$PORT$u")
  magic=$(head -c 5 /tmp/alergen-booklet.pdf)
  case "$ct" in
    application/pdf*) printf "  ok   %-34s content-type %s\n" "$u" "$ct" ;;
    *) printf "  FAIL %-34s content-type got=%s\n" "$u" "$ct"; fail=1 ;;
  esac
  if [ "$magic" = "%PDF-" ] && [ "${sz:-0}" -gt 7000000 ]; then
    printf "  ok   %-34s bytes %s, magic %s\n" "$u" "$sz" "$magic"
  else
    printf "  FAIL %-34s bytes=%s magic=%s\n" "$u" "$sz" "$magic"; fail=1
  fi
done

echo "==> permission policy (voice mode needs microphone=self)"
for p in / /expo/; do
  pol=$(curl -sI "http://127.0.0.1:$PORT$p" | tr -d '\r' | awk -F': ' 'tolower($1)=="permissions-policy"{print $2}')
  case "$pol" in
    *"microphone=(self)"*) printf "  ok   %-10s %s\n" "$p" "$pol" ;;
    *) printf "  FAIL %-10s got=%s\n" "$p" "$pol"; fail=1 ;;
  esac
done

echo "==> robots keeps /expo/ out of search"
curl -fsS "http://127.0.0.1:$PORT/robots.txt" | grep -q 'Disallow: /expo/' \
  && echo "  ok   robots disallow /expo/" || { echo "  FAIL robots disallow"; fail=1; }

echo "==> asset count in image"
sudo docker exec "$NAME" sh -c 'ls /usr/share/nginx/html /usr/share/nginx/html/images | tr "\n" " "; echo'
echo "==> headers"
curl -sI "http://127.0.0.1:$PORT/" | sed -n '1,12p'

sudo docker rm -f "$NAME" >/dev/null
[ "$fail" = 0 ] && echo "✅ ALL CHECKS PASSED" || { echo "❌ CHECKS FAILED"; exit 1; }
