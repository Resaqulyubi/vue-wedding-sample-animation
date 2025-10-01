# Undangan Pernikahan Animasi

Aplikasi web undangan pernikahan yang indah dan interaktif yang dibangun dengan Laravel, Vue.js, dan animasi GSAP.

## Fitur

- **Layar Selamat Datang**: Pesan selamat datang dengan animasi masuk yang elegan
- **Animasi Interaktif**: Kupu-kupu melayang, kelopak bunga jatuh, transisi yang halus
- **Informasi Pernikahan**: Timer hitung mundur langsung, jadwal upacara, informasi lokasi
- **Desain Responsif**: Tata letak yang ramah seluler dengan animasi adaptif

## Teknologi

- **Frontend**: Vue.js 3, GSAP (GreenSock Animation Platform), Animasi CSS3
- **Backend**: Laravel 10, PHP 8.1+
- **Build Tool**: Vite
- **CSS Framework**: TailwindCSS

## Struktur Proyek

```
wedding-sample-animation/
├── resources/
│   ├── js/
│   │   ├── Pages/
│   │   │   └── WeddingInvitation.vue    # Halaman utama undangan pernikahan
│   │   ├── components/
│   │   │   ├── WelcomeScreen.vue        # Layar selamat datang dengan animasi masuk
│   │   │   ├── BackgroundDecorations.vue # Bunga dan kupu-kupu latar belakang
│   │   │   ├── WeddingCountdown.vue     # Komponen timer hitung mundur
│   │   │   └── WeddingSchedule.vue      # Timeline acara pernikahan
│   │   ├── composables/
│   │   │   └── useAnimations.js         # Logika animasi yang dapat digunakan kembali
│   │   └── app.js                       # Titik masuk JavaScript utama
│   ├── css/
│   │   └── app.css                      # Gaya global
│   └── views/
│       └── app.blade.php                # Template view Laravel utama
├── public/
│   └── images/
│       ├── flower1.png                  # Gambar bunga dekoratif
│       ├── flower2.png
│       ├── bg-flower.png
│       └── butterfly.png
└── package.json                         # Dependensi NPM
```

## Memulai

1. Clone repository
2. Install dependensi:
   ```bash
   composer install
   npm install
   ```

3. Buat file environment:
   ```bash
   cp .env.example .env
   php artisan key:generate
   ```

4. Konfigurasikan database Anda di `.env`

5. Jalankan migrasi:
   ```bash
   php artisan migrate
   ```

6. Mulai server pengembangan:
   ```bash
   php artisan serve
   npm run dev
   ```

7. Kunjungi `http://localhost:8000` di browser Anda

## Build untuk Produksi

```bash
npm run build
```

## Deployment

Proyek ini mendukung deployment melalui Docker atau Nixpacks di Coolify.

### Deployment Docker

Proyek ini menyertakan Dockerfile multi-stage yang dioptimalkan untuk produksi:
- Build stage: Mengompilasi aset Vue.js dengan Node.js
- Production stage: Berjalan pada PHP 8.2 FPM dengan Nginx
- Termasuk Supervisor untuk manajemen proses

### Deployment Nixpacks

Metode deployment alternatif dengan deteksi dependensi otomatis:
- Proses deployment yang lebih sederhana
- Ukuran image yang lebih kecil
- Waktu build yang lebih cepat
- Caching bawaan

Kedua opsi deployment termasuk:
- HTTPS dengan sertifikat SSL otomatis
- Kompresi Gzip
- Optimasi performa
- Header keamanan

## Kustomisasi

- Edit detail pernikahan di `resources/js/Pages/WeddingInvitation.vue`
- Modifikasi animasi di file komponen yang sesuai
- Perbarui gaya di bagian style komponen
- Tambah/hapus bagian sesuai kebutuhan

## Lisensi

Proyek ini adalah perangkat lunak open-source yang dilisensikan di bawah lisensi MIT.