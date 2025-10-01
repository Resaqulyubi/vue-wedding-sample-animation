# ܓܕܫܐ ܕܚܬܢܐ ܕܒܝܪܬܐ

ܐܦܠܝܩܝܣܝܘܢ ܐܢܛܪܐܩܛܝܒܝ ܠܓܕܫܐ ܕܚܬܢܐ ܕܒܝܪܬܐ ܒܐܝܢܛܪܢܛ ܡܥܠ ܐܘܦܐܐ ܕܐܢܝܡܫܢ ܒ-GSAP.

## ܓܕܫܐ

- **ܦܐܬܐ ܕܫܠܡܐ**: ܩܪܝܬܐ ܕܫܠܡܐ ܒܐܢܝܡܫܢ ܐܪܝܟܬܐ ܘܡܪܝܪܬܐ
- **ܐܢܝܡܫܢ ܡܦܠܚܬܐ**: ܦܪܦܪܬܐ ܕܦܪܫܪܝܢ ܡܛܪܝܢ, ܙܘܥܬܐ ܕܙܘܥܪ̈ܐ ܕܓܘܢܒܐ, ܡܩܦܙܘܬ̈ܐ ܚܠܦܝܬ̈ܐ
- **ܝܕܥܬܐ ܕܚܬܢܐ ܕܒܝܪܬܐ**: ܙܡܢܐ ܕܚܫܒܐ ܚܝܐ, ܠܘܓܝܣܛܝܩܐ ܕܚܕܬܐ, ܝܕܥܬܐ ܕܐܬܪܐ
- **ܬܒܝܬܐ ܩܒܝܠܬܐ**: ܡܩܪܒܐ ܩܒܝܠ ܠܡܗܒܝܢ ܒܐܢܝܡܫܢ ܡܬܟܢ

## ܛܩܢܝܩ

- **ܦܐܬܐ ܩܕܡܝܬܐ**: Vue.js 3, GSAP (GreenSock Animation Platform), CSS3 Animations
- **ܦܐܬܐ ܐܚܪܝܬܐ**: Laravel 10, PHP 8.1+
- **ܐܠܐ ܒܢܝܐ**: Vite
- **ܛܩܢܝܩ CSS**: TailwindCSS

## ܡܒܢܝܬܐ ܕܦܪܘܝܩܛ

```
wedding-sample-animation/
├── resources/
│   ├── js/
│   │   ├── Pages/
│   │   │   └── WeddingInvitation.vue    # ܦܐܬܐ ܪܝܫܝܬܐ ܕܓܕܫܐ ܕܚܬܢܐ ܕܒܝܪܬܐ
│   │   ├── components/
│   │   │   ├── WelcomeScreen.vue        # ܦܐܬܐ ܕܫܠܡܐ ܒܐܢܝܡܫܢ ܕܡܨܐ
│   │   │   ├── BackgroundDecorations.vue # ܙܘܥܪ̈ܐ ܘܦܪܫܪ̈ܐ ܕܩܘܒܠܐ
│   │   │   ├── WeddingCountdown.vue     # ܟܘܡܦܘܢܢܛ ܕܙܡܢܐ ܕܚܫܒܐ
│   │   │   └── WeddingSchedule.vue      # ܠܘܓܝܣܛܝܩܐ ܕܦܪܚܣ̈ܐ ܕܚܕܬܐ
│   │   ├── composables/
│   │   │   └── useAnimations.js         # ܠܘܓܝܩ ܕܐܢܝܡܫܢ ܐܣܛܘܡܬܐ
│   │   └── app.js                       # ܢܩܘܕܐ ܪܝܫܝܐ ܕJavaScript
│   ├── css/
│   │   └── app.css                      # ܣܛܝܠ ܥܠܡܝܐ
│   └── views/
│       └── app.blade.php                # ܩܠܒܐ ܪܝܫܝܐ ܕLaravel
├── public/
│   └── images/
│       ├── flower1.png                  # ܨܘܪܬ̈ܐ ܕܓܘܢܒܐ ܠܬܒܝܬܐ
│       ├── flower2.png
│       ├── bg-flower.png
│       └── butterfly.png
└── package.json                         # ܬܠܝܡ̈ܐ ܕNPM
```

## ܫܘܪܝܐ ܕܥܒܕܐ

1. ܩܠܒ ܡܢ ܡܩܘܒܥܐ
2. ܦܪܣ ܬܠܝܡ̈ܐ:
   ```bash
   composer install
   npm install
   ```

3. ܒܪܝ ܦܐܬܐ ܕܣܒܒܐ:
   ```bash
   cp .env.example .env
   php artisan key:generate
   ```

4. ܛܒ ܒܝܬܐ ܕܕܝܢܐ ܒ-.env

5. ܐܪܟ ܡܩܦܠܬ̈ܐ:
   ```bash
   php artisan migrate
   ```

6. ܫܪܝ ܫܘܦܝ̈ܐ ܕܦܝܠܚܝܬܐ:
   ```bash
   php artisan serve
   npm run dev
   ```

7. ܙܠ ܠ-`http://localhost:8000` ܒܕܘܝܐ ܕܐܢܬ

## ܒܢܝܐ ܠܡܦܠܚܐ

```bash
npm run build
```

## ܬܦܩܢܐ

ܗܢܐ ܦܪܘܝܩܛ ܣܡܟ ܠܬܦܩܢܐ ܒ-Docker ܐܘ Nixpacks ܥܠ Coolify.

### ܬܦܩܢܐ ܒ-Docker

ܦܪܘܝܩܛ ܚܘܐ Dockerfile ܒܬܪ ܬܪܝܢ ܡܛܒܒ ܠܡܦܠܚܐ:
- ܡܪܩܡܐ ܕܒܢܝܐ: ܩܪܝ ܐܣܬܝܘܬ̈ܐ ܕVue.js ܒ-Node.js
- ܡܪܩܡܐ ܕܡܦܠܚܐ: ܥܒܕ ܥܠ PHP 8.2 FPM ܒ-Nginx
- ܚܘܐ Supervisor ܠܡܕܒܪܢܘܬܐ ܕܦܪܘܩܣܝܣ

### ܬܦܩܢܐ ܒ-Nixpacks

ܛܪܝܩܐ ܐܚܪܢܐ ܕܬܦܩܢܐ ܒܬܚܘܡܐ ܐܘܛܘܡܐܛܝܩܝ ܕܟܫܘܬ ܬܠܝܡ̈ܐ:
- ܦܪܘܩܣܝܣ ܕܬܦܩܢܐ ܦܫܝܛ
- ܩܝܡ̈ܐ ܕܨܘܪܬܐ ܙܥܘܪ̈ܐ
- ܙܡܢ̈ܐ ܕܒܢܝܐ ܡܗܒܒ̈ܐ
- ܟܫܘܬܐ ܒܢܝܬܝܬܐ

ܬܪܝܢܝ ܐܘܦܛܝܘ̈ܐ ܕܬܦܩܢܐ ܚܘܝܢ:
- HTTPS ܒܫܗܕܢ̈ܐ ܐܘܛܘܡܐܛܝܩ̈ܐ ܕSSL
- ܛܒܝܬܐ ܕGzip
- ܐܘܦܛܝܡܝܙܫܢ ܕܦܪܕܝܬܐ
- ܬܘܕ̈ܝ ܕܐܘܡܬܐ

## ܫܘܚܠܦܐ

- ܫܚܠܦ ܝܕܥܬܐ ܕܚܕܬܐ ܒ-`resources/js/Pages/WeddingInvitation.vue`
- ܫܚܠܦ ܐܢܝܡܫܢ ܒܦܐܬ̈ܐ ܕܟܘܡܦܘܢܢܛ
- ܚܕܬ ܣܛܝܠ̈ܐ ܒܩܛܥ̈ܐ ܕܣܛܝܠ ܕܟܘܡܦܘܢܢܛ
- ܐܘܣܦ/ܫܪ ܩܛܦ̈ܐ ܠܦܛ ܡܢ ܒܕܝܬܟ

## ܪܨܐ

ܗܢܐ ܦܪܘܝܩܛ ܗܘ ܨܘܦܪܐ ܚܪܬܐ ܡܬܪܨܡ ܒܪܨܐ ܕMIT.