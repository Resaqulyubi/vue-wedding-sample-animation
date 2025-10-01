# Undhangan Mantenan Animasi

Aplikasi web undhangan mantenan sing apik lan interaktif, digawé nganggo Laravel, Vue.js, lan animasi GSAP.

## Fitur

- **Layar Sambutan**: Pesen sambutan kanthi animasi mlebu sing elegan
- **Animasi Interaktif**: Kupu-kupu mabur, kelopak kembang tiba, transisi sing alus
- **Informasi Mantenan**: Hitung mundur wektu langsung, jadwal upacara, informasi panggonan
- **Desain Responsif**: Tata letak sing ramah seluler kanthi animasi adaptif

## Tumpukan Teknologi

- **Frontend**: Vue.js 3, GSAP (GreenSock Animation Platform), Animasi CSS3
- **Backend**: Laravel 10, PHP 8.1+
- **Alat Build**: Vite
- **Framework CSS**: TailwindCSS

## Struktur Proyek

```
wedding-sample-animation/
├── resources/
│   ├── js/
│   │   ├── Pages/
│   │   │   └── WeddingInvitation.vue    # Kaca undhangan mantenan utama
│   │   ├── components/
│   │   │   ├── WelcomeScreen.vue        # Layar sambutan kanthi animasi mlebu
│   │   │   ├── BackgroundDecorations.vue # Hiasan latar mburi kembang lan kupu-kupu
│   │   │   ├── WeddingCountdown.vue     # Komponen hitung mundur wektu
│   │   │   └── WeddingSchedule.vue      # Garis wektu acara mantenan
│   │   ├── composables/
│   │   │   └── useAnimations.js         # Logika animasi sing bisa digunakaké manèh
│   │   └── app.js                       # Titik lumebu JavaScript utama
│   ├── css/
│   │   └── app.css                      # Gaya global
│   └── views/
│       └── app.blade.php                # Cithakan view Laravel utama
├── public/
│   └── images/
│       ├── flower1.png                  # Gambar kembang hiasan
│       ├── flower2.png
│       ├── bg-flower.png
│       └── butterfly.png
└── package.json                         # Dependensi NPM
```

## Carane Miwiti

1. Goleki repositori
2. Instal dependensi:
   ```bash
   composer install
   npm install
   ```

3. Gawe file lingkungan:
   ```bash
   cp .env.example .env
   php artisan key:generate
   ```

4. Konfigurasi database sampeyan ing `.env`

5. Jalankan migrasi:
   ```bash
   php artisan migrate
   ```

6. Miwiti server pengembangan:
   ```bash
   php artisan serve
   npm run dev
   ```

7. Tengok `http://localhost:8000` ing browser sampeyan

## Build kanggo Produksi

```bash
npm run build
```

## Deployment

Proyek iki ndhukung deployment liwat Docker utawa Nixpacks ing Coolify.

### Deployment Docker

Proyek iki kalebu Dockerfile multi-stage sing dioptimalke kanggo produksi:
- Tahap build: Kompilasi aset Vue.js kanthi Node.js
- Tahap produksi: Lumaku ing PHP 8.2 FPM karo Nginx
- Kalebu Supervisor kanggo manajemen proses

### Deployment Nixpacks

Cara deployment alternatif kanthi pendeteksian dependensi otomatis:
- Proses deployment sing luwih prasaja
- Ukuran gambar sing luwih cilik
- Waktu build sing luwih cepet
- Caching sing digawé ing jero

Kedua opsi deployment kalebu:
- HTTPS kanthi sertifikat SSL otomatis
- Kompresi Gzip
- Optimasi kinerja
- Header keamanan

## Kustomisasi

- Besuk rincian mantenan ing `resources/js/Pages/WeddingInvitation.vue`
- Modifikasi animasi ing file komponen sing relevan
- Update gaya ing bagian gaya komponen
- Tambah/hapus bagian miturut kabutuhan

## Lisensi

Proyek iki minangka perangkat lunak open-source sing dilisensikake miturut lisensi MIT.