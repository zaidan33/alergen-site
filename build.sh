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
check /halaman-tidak-ada 404

echo "==> content assertions"
curl -fsS "http://127.0.0.1:$PORT/" > /tmp/alergen-index.html
python3 - <<'PY'
import sys
h = open('/tmp/alergen-index.html', encoding='utf-8').read()
need = ['<!DOCTYPE html>', '<html lang="id">', 'width=device-width',
        'Sepuluh alergen, satu patch', 'Panel alergen', 'rel="canonical"',
        'application/ld+json', '[hidden] { display: none !important; }']
missing = [n for n in need if n not in h]
print("  ok   html shell + content" if not missing else f"  FAIL missing: {missing}")
sys.exit(1 if missing else 0)
PY

echo "==> asset count in image"
sudo docker exec "$NAME" sh -c 'ls /usr/share/nginx/html /usr/share/nginx/html/images | tr "\n" " "; echo'
echo "==> headers"
curl -sI "http://127.0.0.1:$PORT/" | sed -n '1,12p'

sudo docker rm -f "$NAME" >/dev/null
[ "$fail" = 0 ] && echo "✅ ALL CHECKS PASSED" || { echo "❌ CHECKS FAILED"; exit 1; }
