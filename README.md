# Alergen — situs informasi patch diagnostik

Situs satu halaman (statis) untuk pengembangan **patch diagnostik 10 alergen** dan
**tablet sublingual desensitisasi**. Konten ditujukan untuk klinisi dan mitra; tidak ada
penjualan online.

Live: https://alergen.airlangga.link

## Struktur

```
index.html        halaman utama (dibangun oleh _build_html.py)
404.html          halaman error
favicon.svg       ikon
robots.txt        izin crawler + sitemap
sitemap.xml       satu URL
images/           7 foto produk (.webp)
nginx.conf        konfigurasi server (gzip, cache, security header)
Dockerfile        nginx:1.27-alpine + aset statis
build.sh          build + smoke test (satu-satunya bukti verifikasi)
```

## Shell HTML dibangun oleh script

Fragmen asli dari desain tidak punya `<!DOCTYPE>`, `<head>`, maupun `<meta viewport>` —
di ponsel halaman akan ter-render sebagai desktop. `_build_html.py` membungkus fragmen itu
menjadi dokumen HTML5 lengkap (charset, viewport, canonical, Open Graph, JSON-LD, favicon)
plus dua perbaikan CSS:

- `[hidden] { display: none !important }` — tanpa ini filter produk tidak menyembunyikan
  kartu, karena `.kit { display: grid }` mengalahkan `[hidden]` bawaan browser.
- nav mobile: brand + tombol satu baris, tautan jadi strip yang bisa digeser.

Sumber fragmen: `/tmp/index.orig.html` (ekstrak zip awal). Setelah mengubah `_build_html.py`:

```bash
python3 _build_html.py   # tulis ulang index.html
./build.sh               # build image + sweep rute + assertion konten
```

## Verifikasi

`build.sh` membangun image sebenarnya, menjalankannya di port 8099, lalu memeriksa:

| Rute | Harapan |
|---|---|
| `/`, `/index.html` | 200 |
| `/healthz` | 200 |
| `/robots.txt`, `/sitemap.xml`, `/favicon.svg` | 200 |
| `/images/*.webp` | 200 |
| `/halaman-tidak-ada` | 404 (memakai `404.html`) |
| `/404.html` | 404 (internal saja, mencegah konten duplikat) |

Plus assertion konten: doctype, `lang="id"`, viewport, judul hero, canonical, JSON-LD.

## Deploy

```bash
coolify-deploy git@github.com:zaidan33/alergen-site.git alergen \
  --port 80 --branch main --build-pack dockerfile --name alergen-site
```

## Catatan medis

Halaman menyatakan produk masih dalam pengembangan, patch adalah alat bantu (bukan
pengganti uji tusuk kulit, IgE, atau uji provokasi oral), dan tablet tidak dijual online.
Klaim pasar mencantumkan sumbernya masing-masing di footer.
