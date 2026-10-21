# Alergen — situs informasi kit diagnostik alergi patch transdermal

Situs satu halaman (statis) untuk **kit diagnostik alergi berbasis patch transdermal**
Universitas Airlangga: sepuluh jenis ekstrak alergen dalam satu sistem patch (patch + seal).
Produk dalam pengembangan; validasi klinis masih diperlukan. Tidak ada penjualan online.

Live: https://alergen.airlangga.link

## Struktur

```
index.html        halaman utama (SUMBER TUNGGAL — edit langsung)
404.html          halaman error
favicon.svg       ikon
robots.txt        izin crawler + sitemap
sitemap.xml       satu URL
images/           6 foto produk (.webp)
nginx.conf        konfigurasi server (gzip, cache, security header)
Dockerfile        nginx:1.27-alpine + aset statis
build.sh          build + smoke test (satu-satunya bukti verifikasi)
```

## Sumber tunggal: index.html

Tidak ada lagi langkah generate (`_build_html.py` sudah dihapus; fragmen asal
`/tmp/index.orig.html` sudah tidak ada). `index.html` adalah dokumen HTML5 lengkap
yang diedit langsung:

- konten mengikuti dokumen "Konten Web" (BRIEF-konten-v2.md) — jangan menambah
  klaim, angka pasar, atau tautan riset eksternal di luar dokumen itu;
- selalu tegaskan bahwa validasi klinis belum ada;
- tidak ada produk lain: hanya kit patch transdermal (patch + seal).

Setelah mengubah `index.html`:

```bash
./build.sh               # build image + sweep rute + assertion konten
```

## Verifikasi

`build.sh` membangun image sebenarnya, menjalankannya di port 8099, lalu memeriksa:

| Rute | Harapan |
|---|---|
| `/`, `/index.html` | 200 |
| `/healthz` | 200 |
| `/robots.txt`, `/sitemap.xml`, `/favicon.svg` | 200 |
| `/images/*.webp` (6 gambar) | 200 |
| `/halaman-tidak-ada` | 404 (memakai `404.html`) |
| `/404.html` | 404 (internal saja, mencegah konten duplikat) |

Plus assertion konten: doctype, `lang="id"`, viewport, judul
"Kit Diagnostik Alergi Berbasis Patch Transdermal", "Sepuluh jenis ekstrak alergen",
"Tim inventor", "Junaidi Khotib", "PT Bio Farma", "CD209", "validasi klinis",
canonical, JSON-LD — dan larangan munculnya "Tablet sublingual", "SLIT",
"Grand View", "Panel alergen", "HPMC", "Mordor", `tablet.webp`.

## Deploy

```bash
coolify-deploy git@github.com:zaidan33/alergen-site.git alergen \
  --port 80 --branch main --build-pack dockerfile --name alergen-site
```

## Catatan medis

Halaman menyatakan produk masih dalam pengembangan dan belum tersedia untuk
penjualan, penelitian awal berupa respons imun in vitro (belum menetapkan akurasi
diagnostik maupun keamanan klinis), dan informasi halaman bukan saran medis serta
bukan klaim izin edar.
