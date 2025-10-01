# Wedding Invitation Animation

A beautiful and interactive wedding invitation web application built with Laravel, Vue.js, and GSAP animations.

## Features

- **Welcome Screen**: Animated welcome message with elegant entrance animations
- **Interactive Animations**: Floating butterflies, falling flower petals, smooth transitions
- **Wedding Information**: Live countdown timer, ceremony schedule, venue information
- **Responsive Design**: Mobile-friendly layout with adaptive animations

## Tech Stack

- **Frontend**: Vue.js 3, GSAP (GreenSock Animation Platform), CSS3 Animations
- **Backend**: Laravel 10, PHP 8.1+
- **Build Tool**: Vite
- **CSS Framework**: TailwindCSS

## Project Structure

```
wedding-sample-animation/
├── resources/
│   ├── js/
│   │   ├── Pages/
│   │   │   └── WeddingInvitation.vue    # Main wedding invitation page
│   │   ├── components/
│   │   │   ├── WelcomeScreen.vue        # Welcome screen with entrance animation
│   │   │   ├── BackgroundDecorations.vue # Background flowers and butterflies
│   │   │   ├── WeddingCountdown.vue     # Countdown timer component
│   │   │   └── WeddingSchedule.vue      # Wedding events timeline
│   │   ├── composables/
│   │   │   └── useAnimations.js         # Reusable animation logic
│   │   └── app.js                       # Main JavaScript entry point
│   ├── css/
│   │   └── app.css                      # Global styles
│   └── views/
│       └── app.blade.php                # Main Laravel view template
├── public/
│   └── images/
│       ├── flower1.png                  # Decorative flower images
│       ├── flower2.png
│       ├── bg-flower.png
│       └── butterfly.png
└── package.json                         # NPM dependencies
```

## Getting Started

1. Clone the repository
2. Install dependencies:
   ```bash
   composer install
   npm install
   ```

3. Create environment file:
   ```bash
   cp .env.example .env
   php artisan key:generate
   ```

4. Configure your database in `.env`

5. Run migrations:
   ```bash
   php artisan migrate
   ```

6. Start the development servers:
   ```bash
   php artisan serve
   npm run dev
   ```

7. Visit `http://localhost:8000` in your browser

## Building for Production

```bash
npm run build
```

## Deployment

This project supports deployment via Docker or Nixpacks on Coolify.

### Docker Deployment

The project includes a multi-stage Dockerfile optimized for production:
- Build stage: Compiles Vue.js assets with Node.js
- Production stage: Runs on PHP 8.2 FPM with Nginx
- Includes Supervisor for process management

### Nixpacks Deployment

Alternative deployment method with automatic dependency detection:
- Simpler deployment process
- Smaller image sizes
- Faster build times
- Built-in caching

Both deployment options include:
- HTTPS with automatic SSL certificates
- Gzip compression
- Performance optimizations
- Security headers

## Customization

- Edit wedding details in `resources/js/Pages/WeddingInvitation.vue`
- Modify animations in the respective component files
- Update styles in the component's style sections
- Add/remove sections as needed

## License

This project is open-sourced software licensed under the MIT license.