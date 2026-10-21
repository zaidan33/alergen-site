# BRIEF — Revisi konten situs alergen.airlangga.link (v2)

Repo: `/home/zai/project/alergen-site` (situs statis nginx satu halaman).
Tugas: **ganti seluruh konten halaman** mengikuti brief di bawah. Desain/sistem visual yang ada DIPERTAHANKAN (monokrom premium, tipografi Inter Tight + label mono IBM Plex Mono, satu aksen hijau-teal, TANPA emoji, ikon SVG garis). Yang berubah adalah isi, struktur seksi, dan beberapa komponen baru (tabel inventor, FAQ, kartu mitra, kartu nilai inovasi).

## ATURAN KONTEN (wajib)

1. **Sumber tunggal**: dokumen "Konten Web" yang isinya disalin di bagian KONTEN di bawah. Jangan menambah klaim baru, angka pasar, statistik, atau tautan riset eksternal yang tidak ada di dokumen.
2. **HAPUS** dari versi lama: seluruh bagian tablet sublingual/SLIT/desensitisasi, filter produk "Semua/Patch/Tablet", kartu "Industri alergi" + rail kartu berita pasar, grafik pasar diagnostik global (chart USD 7,09 → 16,37 miliar), semua tautan sumber pasar (Grand View, Mordor, Coherent MI, dll), klaim "matriks HPMC dan PEG", klaim "2 × 5 sumur bulat", klaim "atopy patch test diposisikan EAACI", dan klaim "obat disetujui regulator".
   Alasan: dokumen sumber tidak memuat itu dan situs harus konsisten dengan deskripsi invensi.
3. Nada: hati-hati, faktual, tanpa klaim berlebihan. Selalu tegaskan bahwa validasi klinis belum ada.
4. Bahasa Indonesia baku. Pertahankan istilah asli dokumen (mis. "seal", "patch transdermal", "in vitro").

## STRUKTUR HALAMAN BARU

Urutan seksi dan anchor id:

1. `#top` — Hero
2. `#produk` — Tentang produk
3. `#alergen` — Jenis ekstrak alergen
4. `#teknologi` — Teknologi produk (dua komponen) + prinsip kerja
5. `#nilai` — Nilai inovasi (4 kartu)
6. `#penelitian` — Landasan penelitian
7. `#tim` — Universitas Airlangga + tabel tim inventor
8. `#kerjasama` — Pengembangan dan kerja sama (daftar peluang + CTA)
9. `#faq` — Pertanyaan yang sering diajukan (5 item)
10. `#mitra` — Mitra pengembangan dan kolaborasi (4 kartu)
11. Footer `#kontak` — informasi penting + kolom tautan + email

Nav (5 tautan + tombol): Produk · Alergen · Teknologi · Penelitian · Tim, tombol "Hubungi tim" → `#kontak`.

## KONTEN (salin apa adanya; boleh dipecah ke heading/paragraf)

### 1. Hero (#top)
- Eyebrow mono: `Inovasi Universitas Airlangga`
- H1: `Kit Diagnostik Alergi Berbasis Patch Transdermal`
- Subjudul/lead: `Inovasi Universitas Airlangga untuk Pengembangan Diagnosis Alergi yang Lebih Praktis`
- Paragraf: `Kit diagnostik alergi berbentuk patch transdermal merupakan inovasi Universitas Airlangga yang mengintegrasikan sepuluh jenis ekstrak alergen dalam satu sistem patch. Teknologi ini dirancang untuk mendukung identifikasi respons terhadap alergen melalui aplikasi pada permukaan kulit tanpa penusukan.`
- Ganti dua kartu "kit" lama (patch/tablet) dengan dua kartu ringkas tanpa filter:
  - Kartu 1 — judul `Patch ekstrak alergen`, sub `Sepuluh ekstrak dalam satu sistem`, ikon SVG patch 8 sumur, tautan `#teknologi`.
  - Kartu 2 — judul `Seal pelindung`, sub `Menutup patch sebelum aplikasi`, ikon SVG seal/lingkaran, tautan `#teknologi`.
- Hapus `.pills` (filter) dan JS filter terkait.

### 2. Tentang produk (#produk)
- Label mono: `Tentang produk`
- H2: `Sepuluh Ekstrak Alergen dalam Satu Sistem Patch`
- Paragraf 1: `Kit ini dikembangkan sebagai kandidat perangkat diagnostik alergi dengan memanfaatkan ekstrak alergen yang ditempatkan dalam sediaan patch transdermal. Sistemnya terdiri atas bagian patch yang mengandung ekstrak alergen dan bagian seal sebagai penutup.`
- Paragraf 2: `Melalui kontak dengan kulit, komponen alergen diharapkan dapat menimbulkan respons yang mendukung proses identifikasi alergi. Efektivitas diagnostik, keamanan penggunaan pada manusia, dan interpretasi hasil masih memerlukan validasi klinis.`
- Stats (3): `10` / `ekstrak alergen dalam satu sistem`; `2` / `komponen: patch dan seal`; `1` / `sistem patch transdermal`.
- Dua kolom produk (gaya `.pcols` lama, isi baru):
  - `Patch` — `Bahan polimer sebagai pembawa ekstrak alergen; dirancang untuk mendukung kontak antara ekstrak alergen dan permukaan kulit.` gambar `images/patch-atas.webp`, spec mono `POLIMER PEMBAWA · EKSTRAK ALERGEN`.
  - `Seal pelindung` — `Menutup bagian patch sebelum aplikasi dan membantu melindungi komponen di dalamnya dari paparan lingkungan.` gambar `images/patch-samping.webp`, spec mono `SEAL · PELINDUNG SEBELUM APLIKASI`.

### 3. Jenis ekstrak alergen (#alergen)
- Label mono: `Jenis ekstrak alergen`, H2: `Sepuluh jenis ekstrak alergen`
- Pengantar: `Berdasarkan deskripsi invensi, kit memuat sepuluh jenis ekstrak alergen:`
- Daftar bernomor 01–10, urutan PERSIS seperti dokumen:
  1 Tungau debu rumah · 2 Udang · 3 Susu sapi · 4 Daging · 5 Ayam · 6 Telur · 7 Gandum · 8 Kacang tanah · 9 Kelapa atau santan · 10 Serbuk sari atau polen
  (label mono = nomor `01`…`10`, bukan kategori hirup/makanan — kategori itu tidak ada di dokumen.)
- Catatan kecil: `Susunan dan jumlah sumur pada patch final dapat berbeda.`

### 4. Teknologi produk (#teknologi)
- Label mono: `Teknologi produk`, H2: `Dua komponen utama`
- Sub: `Patch yang mengandung ekstrak alergen` + `Seal pelindung` — gunakan kembali dua paragraf berikut:
  - `Bagian utama kit menggunakan bahan polimer sebagai pembawa ekstrak alergen. Komponen ini dirancang untuk mendukung kontak antara ekstrak alergen dan permukaan kulit.`
  - `Seal menutup bagian patch sebelum aplikasi dan membantu melindungi komponen di dalamnya dari paparan lingkungan.`
- Sub-blok `Prinsip kerja` (id `#cara-kerja`) dengan 3 langkah:
  - `01 · Buka` — `Buka seal` — `Seal dibuka sebelum patch diaplikasikan.`
  - `02 · Tempel` — `Aplikasi pada kulit` — `Patch ditempelkan pada area kulit yang ditentukan dalam protokol, seperti lengan bawah.`
  - `03 · Evaluasi` — `Respons dievaluasi` — `Kontak ekstrak alergen dengan kulit ditujukan untuk menghasilkan respons yang selanjutnya dievaluasi dalam proses pengembangan diagnostik.`
- Kotak catatan (gaya `.note` sinyal): label mono `Batas pengetahuan saat ini`, isi: `Lama aplikasi, waktu pembacaan, kriteria hasil, dan prosedur keselamatan perlu ditetapkan melalui penelitian serta validasi klinis.`
- Gambar lebar `images/patch-miring.webp` (aspect 21/9) di antara blok komponen dan prinsip kerja.

### 5. Nilai inovasi (#nilai)
H2: `Nilai inovasi`. Empat kartu (grid 2×2 di desktop, 1 kolom di ponsel). Judul + isi:
1. `Dirancang untuk aplikasi tanpa penusukan` — `Bentuk patch memungkinkan aplikasi melalui permukaan kulit. Pendekatan ini dikembangkan dengan mempertimbangkan kemudahan aplikasi dan kenyamanan pengguna.`
2. `Integrasi berbagai ekstrak alergen` — `Sepuluh jenis ekstrak alergen dimuat dalam satu sistem kit. Integrasi ini menjadi bagian utama konsep teknologi yang dikembangkan.`
3. `Bentuk sediaan yang praktis` — `Kombinasi patch dan seal menawarkan desain yang sederhana untuk mendukung pengembangan perangkat diagnostik berbasis kontak kulit.`
4. `Peluang pengembangan teknologi kesehatan dalam negeri` — `Inovasi ini membuka peluang pengembangan kapasitas riset, formulasi, pengendalian mutu, dan produksi ekstrak alergen di Indonesia.`

### 6. Landasan penelitian (#penelitian)
- Label mono: `Landasan penelitian`, H2: `Dari respons seluler menuju validasi klinis`
- P1: `Penelitian pendahuluan yang dijelaskan dalam dokumen invensi menunjukkan bahwa ekstrak alergen yang dikembangkan mampu menginduksi pematangan sel dendritik dari sel mononuklear darah perifer manusia secara in vitro.`
- P2: `Pengamatan mencakup perubahan penanda sel, termasuk CD209 dan CD86, serta respons sitokin proinflamasi. Temuan tersebut menjadi landasan awal untuk mempelajari interaksi ekstrak alergen dengan sistem imun.`
- Kotak catatan: `Hasil penelitian seluler ini belum menetapkan akurasi diagnostik maupun keamanan klinis kit pada manusia. Penelitian lanjutan diperlukan untuk mengevaluasi kinerja produk secara menyeluruh.`
- Gunakan gambar `images/detail-makro.webp` sebagai visual pendamping (tata letak dua kolom seperti `.why` lama).

### 7. Universitas Airlangga + tim inventor (#tim)
- Label mono: `Universitas Airlangga`, H2: `Pengembangan inovasi melalui kolaborasi lintas disiplin`
- P1: `Kit diagnostik alergi berbasis patch transdermal dikembangkan oleh tim inventor yang melibatkan unsur Fakultas Farmasi, Fakultas Ekonomi dan Bisnis, Fakultas Sains dan Teknologi, serta Fakultas Perikanan dan Kelautan Universitas Airlangga.`
- P2: `Kolaborasi lintas disiplin ini mendukung pengembangan gagasan teknologi kesehatan, mulai dari kajian ilmiah dan pengembangan produk hingga peluang pemanfaatannya.`
- P3: `Dalam surat pernyataan pengalihan hak invensi yang menjadi dokumen pendukung, Universitas Airlangga disebut sebagai pihak penerima pengalihan hak atas invensi dari para inventor.`
- Sub-judul: `Tim inventor` — `Para inventor di balik pengembangan teknologi`
- Tabel (kolom: No. · Nama inventor · Afiliasi). Baris:
  1. Prof. apt. Junaidi Khotib, S.Si., M.Kes., Ph.D. — Fakultas Farmasi, Universitas Airlangga
  2. Prof. Dr. Muhammad Nafik Hadi Ryandono, S.E., M.Si. — Fakultas Ekonomi dan Bisnis, Universitas Airlangga
  3. Andi Hamim Zaidan, S.Si., M.Si., Ph.D. — Fakultas Sains dan Teknologi, Universitas Airlangga
  4. Daruti Dinda Nindarwi, S.Pi., M.P. — Fakultas Perikanan dan Kelautan, Universitas Airlangga
  5. apt. Ahmad Dzulfikri Nurhan, S.Farm., M.Farm. — Fakultas Farmasi, Universitas Airlangga
  6. Dr. apt. Honey Dzikri Marhaeny, S.Farm., M.Farm. — Fakultas Farmasi, Universitas Airlangga
  7. Dr. apt. Yusuf Alif Pratama, S.Farm., M.Farm. — Fakultas Farmasi, Universitas Airlangga
- Tabel harus: `<caption>` (bisa visually-hidden) + `<thead>` + `<tbody>`, nomor kolom sempit & mono, border-bottom tipis antar baris, bisa digeser horizontal di ponsel (wrapper `overflow-x:auto`), tanpa zebra.

### 8. Pengembangan dan kerja sama (#kerjasama)
- Label mono: `Pengembangan dan kerja sama`, H2: `Membuka peluang riset dan hilirisasi`
- P: `Pengembangan kit diarahkan menuju teknologi diagnostik yang memiliki dasar ilmiah, mutu yang konsisten, dan kinerja klinis yang terukur.`
- Daftar peluang kolaborasi (6 item, bullet dengan garis):
  1. Penelitian dan standardisasi ekstrak alergen.
  2. Optimasi formulasi serta karakterisasi patch.
  3. Pengujian stabilitas dan pengembangan pengendalian mutu.
  4. Validasi klinis untuk mengevaluasi keamanan dan kinerja diagnostik.
  5. Pengembangan proses produksi dan pemenuhan persyaratan regulasi.
  6. Penjajakan lisensi serta kemitraan pengembangan teknologi.
- CTA (blok `.cta` dengan gambar `images/cta-gelap.webp`): H2 `Mari kembangkan bersama`, P `Peluang riset, validasi, dan hilirisasi terbuka bagi mitra akademik maupun industri.`, tombol `Hubungi tim` → `mailto:info@alergen.unair.ac.id`.

### 9. FAQ (#faq)
Lima pasang Q/A, pakai `<details>/<summary>` native (styling mono untuk pertanyaan, marker +/− sendiri, border-bottom tipis, `summary::-webkit-details-marker{display:none}`):
1. `Apa tujuan pengembangan kit ini?` — `Kit dikembangkan untuk mendukung identifikasi respons terhadap alergen melalui aplikasi ekstrak alergen dalam bentuk patch pada kulit.`
2. `Apakah kit ini merupakan terapi alergi?` — `Tujuan invensi ini adalah pengembangan diagnostik alergi. Penggunaannya sebagai terapi tidak menjadi tujuan produk dalam deskripsi invensi yang disajikan.`
3. `Apakah hasil penelitian awal sudah membuktikan akurasi diagnosis?` — `Penelitian awal yang dijelaskan berfokus pada respons imun secara in vitro. Akurasi diagnostik pada manusia masih perlu dibuktikan melalui validasi klinis.`
4. `Apakah produk dapat digunakan sendiri di rumah?` — `Dokumen yang tersedia belum menetapkan prosedur penggunaan mandiri. Penggunaan pada manusia harus mengikuti protokol penelitian atau petunjuk resmi sesuai tahap pengembangan dan perizinannya.`
5. `Apakah produk sudah tersedia secara komersial?` — `Ketersediaan komersial dan status izin edar belum dikonfirmasi dalam dokumen yang menjadi dasar informasi website ini.`

### 10. Mitra (#mitra)
- Label mono: `Mitra pengembangan`, H2: `Membangun inovasi melalui kolaborasi nasional dan internasional`
- P: `Pengembangan inovasi kit diagnostik alergi berbasis patch transdermal Universitas Airlangga didukung oleh jejaring kemitraan yang menghubungkan dunia akademik, penelitian, dan industri. Kolaborasi ini diarahkan untuk memperkuat landasan ilmiah, pengembangan teknologi, serta peluang hilirisasi produk.`
- Empat kartu (grid 2×2, gaya `.rcard` putih dengan border):
  1. `PT Bio Farma (Persero)` — `Mitra industri nasional dalam jejaring pengembangan inovasi, yang membuka peluang sinergi antara hasil penelitian perguruan tinggi dan kebutuhan industri kesehatan.` label mono `Industri · Indonesia`
  2. `International Islamic University Malaysia (IIUM)` — `Mitra akademik internasional melalui Kulliyyah of Pharmacy, yang mendukung jejaring penelitian dan pertukaran pengetahuan dalam bidang farmasi serta pengembangan teknologi kesehatan.` label `Akademik · Malaysia`
  3. `Freie Universität Berlin` — `Mitra akademik internasional melalui Department of Pharmacy, yang memperkuat jejaring keilmuan dan kolaborasi penelitian dalam bidang farmasi.` label `Akademik · Jerman`
  4. `University of Groningen` — `Mitra akademik internasional dalam jejaring penelitian farmasi, yang mendukung pertukaran pengetahuan dan pengembangan pendekatan ilmiah untuk inovasi kesehatan.` label `Akademik · Belanda`
- Penutup: `Melalui kemitraan tersebut, Universitas Airlangga mendorong pengembangan teknologi diagnostik alergi menuju tahapan penelitian lanjutan, validasi, dan pemanfaatan yang lebih luas.`

### 11. Footer (#kontak) — Informasi penting
- Kotak informasi penting (gaya `.note`, tapi di footer boleh netral/soft): label mono `Informasi penting`, isi: `Informasi pada halaman ini menjelaskan teknologi dan arah pengembangannya. Validasi klinis masih diperlukan untuk menetapkan keamanan, efektivitas diagnostik, dan prosedur penggunaan. Informasi ini tidak menggantikan pemeriksaan maupun konsultasi dengan tenaga kesehatan.`
- Kolom footer: Produk (Tentang produk, Jenis ekstrak alergen, Teknologi) · Informasi (Prinsip kerja, Landasan penelitian, FAQ) · Kontak (info@alergen.unair.ac.id, Universitas Airlangga, Surabaya) · Mitra (Mitra pengembangan, Kerja sama).
- Baris legal: `Produk dalam pengembangan dan belum tersedia untuk penjualan. Informasi di halaman ini bukan saran medis dan bukan klaim izin edar.`
- Hapus blok `.srcs` (daftar sumber pasar) — tidak relevan lagi.
- Copyright: `2026 Alergen · Universitas Airlangga` dan `Dalam pengembangan`.

## META / SEO (perbarui)
- `<title>`: `Kit Diagnostik Alergi Berbasis Patch Transdermal — Universitas Airlangga`
- meta description: `Kit diagnostik alergi berbasis patch transdermal dari Universitas Airlangga: sepuluh ekstrak alergen dalam satu sistem patch. Dalam pengembangan, memerlukan validasi klinis.`
- og:title / twitter:title: `Kit Diagnostik Alergi Berbasis Patch Transdermal`
- og:description / twitter:description: `Sepuluh ekstrak alergen dalam satu sistem patch. Inovasi Universitas Airlangga, dalam pengembangan.`
- JSON-LD: ganti `@type` menjadi `["Organization","MedicalDevice"]`? **Jangan** — pertahankan `Organization` saja (aman), perbarui `name` jadi `Kit Diagnostik Alergi — Universitas Airlangga`, `description` sesuai meta, dan tambahkan `parentOrganization` Universitas Airlangga (`https://www.unair.ac.id/`).
- `<html lang="id">`, canonical tetap `https://alergen.airlangga.link/`.

## TEKNIS
- **`index.html` menjadi sumber tunggal** sekarang (fragmen `/tmp/index.orig.html` sudah tidak ada). Hapus `_build_html.py` dan perbarui README: tidak ada lagi langkah generate; edit `index.html` langsung, lalu `./build.sh`.
- Pertahankan: token CSS (`:root` light/dark), font, `.sheet/.in/.box/.sec/.mono/.dotlabel/.btn/.note/.slot`, media query, skip-link bila ada, `[hidden]{display:none!important}`, nav mobile strip, `scroll-margin-top`.
- Hapus CSS/JS yang jadi mati: `.pills`, `[data-filter]`, `[data-kind]`, `.chart`, `.crow`, `.rail/.rcard/.railbar/.prog/.arrow`, `.tabs/.tpanel`, `.pcol .spec` boleh tetap bila masih dipakai. Hapus juga JS filter produk & rail; pertahankan JS tabs? Tabs dihapus (tidak ada di struktur baru) → hapus JS tabs juga. Sisa JS: tidak wajib ada; bila tak ada interaksi, hapus `<script>` sepenuhnya (kecuali perlu).
- Hapus gambar `images/tablet.webp` dari repo dan dari README (produk tablet dihapus).
- Komponen baru yang perlu CSS: `.valu-grid` (kartu nilai), `.tbl` (tabel inventor), `.faq details`, `.mitra-grid` (kartu mitra), `.opps` (daftar peluang). Semua harus responsif (≤860px 1 kolom, ≤480px penyesuaian padding/font).
- Kontras teks minimal WCAG AA; fokus keyboard terlihat (`:focus-visible` sudah ada).
- `sitemap.xml`: perbarui `<lastmod>` ke tanggal hari ini (2026-10-21).
- `build.sh`: perbarui assertion konten agar memeriksa teks baru, minimal:
  `'Kit Diagnostik Alergi Berbasis Patch Transdermal'`, `'Sepuluh jenis ekstrak alergen'`, `'Tim inventor'`, `'Junaidi Khotib'`, `'PT Bio Farma'`, `'CD209'`, `'validasi klinis'`, dan **pastikan tidak ada** `'Tablet sublingual'`, `'SLIT'`, `'Grand View'`.
  Hapus assertion `'Panel alergen'` lama; sesuaikan juga daftar aset gambar (tanpa tablet.webp).
- README: perbarui deskripsi produk (hanya kit patch, tanpa tablet), struktur file, bagian "sumber tunggal", dan catatan medis.

## KRITERIA SELESAI (harus dibuktikan)
1. `./build.sh` lulus semua cek (build image, sweep rute, assertion konten) → tempel output ringkasnya.
2. `grep` membuktikan tidak ada sisa "Tablet", "SLIT", "sublingual", "HPMC", "2 × 5", "Grand View", "Mordor" di `index.html`.
3. `python3 -c` HTML sanity: satu `<h1>`, tidak ada anchor `href="#..."` yang menunjuk id tak ada, semua `<img src>` merujuk file yang ada di `images/`.
4. Tabel inventor berisi tepat 7 baris data; FAQ tepat 5 `<details>`.
5. Tidak ada emoji di markup.
