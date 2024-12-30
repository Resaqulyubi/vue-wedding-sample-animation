<p align="center"><a href="https://laravel.com" target="_blank"><img src="https://raw.githubusercontent.com/laravel/art/master/logo-lockup/5%20SVG/2%20CMYK/1%20Full%20Color/laravel-logolockup-cmyk-red.svg" width="400" alt="Laravel Logo"></a></p>

<p align="center">
<a href="https://github.com/laravel/framework/actions"><img src="https://github.com/laravel/framework/workflows/tests/badge.svg" alt="Build Status"></a>
<a href="https://packagist.org/packages/laravel/framework"><img src="https://img.shields.io/packagist/dt/laravel/framework" alt="Total Downloads"></a>
<a href="https://packagist.org/packages/laravel/framework"><img src="https://img.shields.io/packagist/v/laravel/framework" alt="Latest Stable Version"></a>
<a href="https://packagist.org/packages/laravel/framework"><img src="https://img.shields.io/packagist/l/laravel/framework" alt="License"></a>
</p>

# Wedding Invitation Animation

A beautiful and interactive wedding invitation web application built with Laravel, Vue.js, and GSAP animations.

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

## Components

### WeddingInvitation.vue
The main container component that orchestrates all sub-components and manages the overall layout.

### WelcomeScreen.vue
Handles the initial welcome screen with:
- Elegant entrance animations
- Couple's names display
- Wedding date
- Enter button with smooth transition

### BackgroundDecorations.vue
Manages all decorative elements:
- Corner flower decorations
- Animated floating flowers
- Butterfly animations using GSAP
- Responsive design for all screen sizes

### WeddingCountdown.vue
Displays a countdown timer until the wedding day:
- Days, hours, minutes countdown
- Animated number transitions
- Elegant typography

### WeddingSchedule.vue
Shows the wedding event timeline:
- Event schedule with times
- Event descriptions
- Animated timeline display

## Animations

The project uses GSAP (GreenSock Animation Platform) for smooth animations:
- Flower floating animations
- Butterfly path animations
- Welcome screen transitions
- Timeline reveal animations

## Composables

### useAnimations.js
A composable that contains reusable animation logic:
- Flower animation generation
- Butterfly path creation
- Background animation management
- Animation cleanup utilities

## Dependencies

- Laravel - Backend framework
- Vue.js - Frontend framework
- GSAP - Animation library
- Vite - Build tool
- TailwindCSS - Utility-first CSS framework

## Getting Started

1. Clone the repository
2. Install dependencies:
```bash
composer install
npm install
```

3. Start the development server:
```bash
php artisan serve
```

4. Start the Vite development server:
```bash
npm run dev
```

5. Visit `http://localhost:8000` in your browser

## Building for Production

```bash
npm run build
```

This will generate optimized assets in the `public/build` directory.

## Features

- **Welcome Screen**
  - Animated welcome message
  - Elegant entrance animations
  - Couple names and wedding date display

- **Interactive Animations**
  - Floating butterflies with natural movement
  - Falling flower petals
  - Smooth transitions between sections

- **Wedding Information**
  - Live countdown timer
  - Detailed ceremony schedule
  - Venue information with map
  - RSVP functionality
  - Additional information sections

- **Responsive Design**
  - Mobile-friendly layout
  - Adaptive animations
  - Cross-browser compatibility

## Tech Stack

- **Frontend**
  - Vue.js 3
  - GSAP (GreenSock Animation Platform)
  - CSS3 Animations
  - Responsive Design

- **Backend**
  - Laravel 10
  - PHP 8.1+
  - MySQL

## Installation

1. Clone the repository:
   ```bash
   git clone [your-repository-url]
   ```

2. Install PHP dependencies:
   ```bash
   composer install
   ```

3. Install Node.js dependencies:
   ```bash
   npm install
   ```

4. Create environment file:
   ```bash
   cp .env.example .env
   ```

5. Generate application key:
   ```bash
   php artisan key:generate
   ```

6. Configure your database in `.env`

7. Run migrations:
   ```bash
   php artisan migrate
   ```

8. Build assets:
   ```bash
   npm run build
   ```

9. Start the development server:
   ```bash
   php artisan serve
   ```

## Usage

1. Access the website through the provided URL
2. Enter through the welcome screen
3. Navigate through the wedding information sections
4. Use the RSVP feature to confirm attendance

## Customization

You can customize various aspects of the invitation:

- Edit wedding details in `resources/js/Pages/WeddingInvitation.vue`
- Modify animations in the respective component files
- Update styles in the component's style sections
- Add/remove sections as needed

## Contributing

Contributions are welcome! Please feel free to submit a Pull Request.

## About Laravel

Laravel is a web application framework with expressive, elegant syntax. We believe development must be an enjoyable and creative experience to be truly fulfilling. Laravel takes the pain out of development by easing common tasks used in many web projects, such as:

- [Simple, fast routing engine](https://laravel.com/docs/routing).
- [Powerful dependency injection container](https://laravel.com/docs/container).
- Multiple back-ends for [session](https://laravel.com/docs/session) and [cache](https://laravel.com/docs/cache) storage.
- Expressive, intuitive [database ORM](https://laravel.com/docs/eloquent).
- Database agnostic [schema migrations](https://laravel.com/docs/migrations).
- [Robust background job processing](https://laravel.com/docs/queues).
- [Real-time event broadcasting](https://laravel.com/docs/broadcasting).

Laravel is accessible, powerful, and provides tools required for large, robust applications.

## Learning Laravel

Laravel has the most extensive and thorough [documentation](https://laravel.com/docs) and video tutorial library of all modern web application frameworks, making it a breeze to get started with the framework.

You may also try the [Laravel Bootcamp](https://bootcamp.laravel.com), where you will be guided through building a modern Laravel application from scratch.

If you don't feel like reading, [Laracasts](https://laracasts.com) can help. Laracasts contains thousands of video tutorials on a range of topics including Laravel, modern PHP, unit testing, and JavaScript. Boost your skills by digging into our comprehensive video library.

## Laravel Sponsors

We would like to extend our thanks to the following sponsors for funding Laravel development. If you are interested in becoming a sponsor, please visit the [Laravel Partners program](https://partners.laravel.com).

### Premium Partners

- **[Vehikl](https://vehikl.com/)**
- **[Tighten Co.](https://tighten.co)**
- **[WebReinvent](https://webreinvent.com/)**
- **[Kirschbaum Development Group](https://kirschbaumdevelopment.com)**
- **[64 Robots](https://64robots.com)**
- **[Curotec](https://www.curotec.com/services/technologies/laravel/)**
- **[Cyber-Duck](https://cyber-duck.co.uk)**
- **[DevSquad](https://devsquad.com/hire-laravel-developers)**
- **[Jump24](https://jump24.co.uk)**
- **[Redberry](https://redberry.international/laravel/)**
- **[Active Logic](https://activelogic.com)**
- **[byte5](https://byte5.de)**
- **[OP.GG](https://op.gg)**

## Contributing

Thank you for considering contributing to the Laravel framework! The contribution guide can be found in the [Laravel documentation](https://laravel.com/docs/contributions).

## Code of Conduct

In order to ensure that the Laravel community is welcoming to all, please review and abide by the [Code of Conduct](https://laravel.com/docs/contributions#code-of-conduct).

## Security Vulnerabilities

If you discover a security vulnerability within Laravel, please send an e-mail to Taylor Otwell via [taylor@laravel.com](mailto:taylor@laravel.com). All security vulnerabilities will be promptly addressed.

## License

The Laravel framework is open-sourced software licensed under the [MIT license](https://opensource.org/licenses/MIT).

## Deployment Options

### Option 1: Docker Deployment

This project includes Docker configuration for easy deployment with Coolify.

### Docker Configuration Files

```
wedding-sample-animation/
├── Dockerfile              # Multi-stage build for production
├── .dockerignore          # Files to exclude from Docker build
└── docker/
    ├── nginx.conf         # Nginx web server configuration
    ├── supervisord.conf   # Process management configuration
    └── php.ini            # PHP configuration for production
```

### Docker Deployment Steps

1. Push your code to a Git repository

2. In Coolify:
   - Create a new service
   - Select "Docker" as deployment type
   - Connect your Git repository
   - Use the following build configuration:
     ```
     Dockerfile Path: ./Dockerfile
     Container Port: 9600
     ```

3. Environment Variables:
   - Copy `.env.example` to `.env`
   - Update the following variables:
     ```
     APP_ENV=production
     APP_DEBUG=false
     APP_URL=your-domain.com
     
     DB_CONNECTION=mysql
     DB_HOST=your-db-host
     DB_PORT=3306
     DB_DATABASE=your-db-name
     DB_USERNAME=your-username
     DB_PASSWORD=your-password
     ```

4. Build and Deploy:
   - Click "Deploy" in Coolify
   - Wait for the build and deployment process to complete
   - Your app will be available at the configured domain

### Docker Image Details

The Docker configuration uses a multi-stage build process:

1. Build Stage:
   - Uses Node.js to build frontend assets
   - Compiles and optimizes all Vue.js components
   - Generates production-ready assets

2. Production Stage:
   - Uses PHP 8.2 with FPM on Alpine Linux
   - Includes Nginx as web server
   - Uses Supervisor for process management
   - Optimized for production performance
   - Includes caching and compression

### Production Optimizations

- Static file caching (30 days)
- Gzip compression for text files
- PHP OPcache enabled
- Optimized PHP-FPM configuration
- Nginx performance tuning
- Supervisor process management

### Monitoring and Logs

Access logs through Coolify's dashboard:
- Nginx access and error logs
- PHP-FPM logs
- Supervisor process logs

### Scaling

The Docker configuration is designed to be scalable:
- Stateless application design
- Optimized for container orchestration
- Ready for horizontal scaling

### Option 2: Nixpacks Deployment

This project also supports deployment using Nixpacks, which provides a simpler deployment process with automatic dependency detection.

### Nixpacks Configuration Files

```
wedding-sample-animation/
├── nixpacks.toml          # Nixpacks build configuration
└── docker/               # Shared configuration files
    ├── nginx.conf        # Nginx web server configuration
    └── php.ini          # PHP configuration for production
```

### Nixpacks Deployment Steps

1. Push your code to a Git repository

2. In Coolify:
   - Create a new service
   - Select "Nixpacks" as deployment type
   - Connect your Git repository
   - Set the following configuration:
     ```
     Port: 9600
     Start Command: Already configured in nixpacks.toml
     ```

3. Environment Variables:
   - Copy `.env.example` to `.env`
   - Add these additional environment variables:
     ```
     NIXPACKS_PKGS=openssl
     ```
   - Update the following variables:
     ```
     APP_ENV=production
     APP_DEBUG=false
     APP_URL=your-domain.com
     
     DB_CONNECTION=mysql
     DB_HOST=your-db-host
     DB_PORT=3306
     DB_DATABASE=your-db-name
     DB_USERNAME=your-username
     DB_PASSWORD=your-password
     ```

4. Build and Deploy:
   - Click "Deploy" in Coolify
   - Nixpacks will automatically:
     - Install PHP 8.2 with extensions
     - Install Node.js 18
     - Install Nginx
     - Build frontend assets
     - Configure services

### Nixpacks Build Process

The Nixpacks configuration includes several phases:

1. Setup Phase:
   - Installs PHP 8.2 with required extensions
   - Installs Node.js 18
   - Sets up Nginx

2. Install Phase:
   - Installs Composer dependencies
   - Installs NPM packages
   - Builds frontend assets

3. Setup Nginx Phase:
   - Configures Nginx web server
   - Sets up PHP-FPM configuration

4. Setup Permissions Phase:
   - Sets correct permissions for Laravel storage
   - Ensures proper file ownership

### Process Management

The application runs with:
- PHP-FPM for PHP processing
- Nginx for web serving
- Both services managed directly by the container

### Advantages of Nixpacks

- Simpler deployment process
- Automatic dependency detection
- Consistent builds across environments
- Smaller image sizes
- Faster build times
- Built-in caching

### Coolify Deployment Configuration

#### Port Configuration
```
Ports Exposes: 9600
Ports Mappings: 9600:9600
```

#### Container Labels for Traefik
```
traefik.enable=true
traefik.http.middlewares.gzip.compress=true
traefik.http.middlewares.redirect-to-https.redirectscheme.scheme=https

# HTTP Router Configuration
traefik.http.routers.http-0-awcc0ggoc088080gos4o04k8.entryPoints=http
traefik.http.routers.http-0-awcc0ggoc088080gos4o04k8.middlewares=redirect-to-https
traefik.http.routers.http-0-awcc0ggoc088080gos4o04k8.rule=Host(`wedding-kemash.nury.my.id`) && PathPrefix(`/`)
traefik.http.routers.http-0-awcc0ggoc088080gos4o04k8.service=http-0-awcc0ggoc088080gos4o04k8

# HTTPS Router Configuration
traefik.http.routers.https-0-awcc0ggoc088080gos4o04k8.entryPoints=https
traefik.http.routers.https-0-awcc0ggoc088080gos4o04k8.middlewares=gzip
traefik.http.routers.https-0-awcc0ggoc088080gos4o04k8.rule=Host(`wedding-kemash.nury.my.id`) && PathPrefix(`/`)
traefik.http.routers.https-0-awcc0ggoc088080gos4o04k8.service=https-0-awcc0ggoc088080gos4o04k8
traefik.http.routers.https-0-awcc0ggoc088080gos4o04k8.tls.certresolver=letsencrypt
traefik.http.routers.https-0-awcc0ggoc088080gos4o04k8.tls=true

# Service Configuration
traefik.http.services.http-0-awcc0ggoc088080gos4o04k8.loadbalancer.server.port=9600
traefik.http.services.https-0-awcc0ggoc088080gos4o04k8.loadbalancer.server.port=9600
```

#### Caddy Configuration
```
caddy_0.encode=zstd gzip
caddy_0.handle_path.0_reverse_proxy={{upstreams 9600}}
caddy_0.handle_path=/*
caddy_0.header=-Server
caddy_0.try_files={path} /index.html /index.php
caddy_0=https://wedding-kemash.nury.my.id
caddy_ingress_network=coolify
```

### Features Enabled
- HTTPS with automatic SSL certificate (Let's Encrypt)
- HTTP to HTTPS redirection
- Gzip compression for better performance
- Reverse proxy configuration
- Custom domain support
- Load balancing ready
- Security headers

### Domain Configuration
The application will be accessible at:
- HTTPS: `https://wedding-kemash.nury.my.id`
- HTTP (redirects to HTTPS): `http://wedding-kemash.nury.my.id`

### Security Features
1. Automatic HTTPS redirection
2. SSL/TLS encryption with Let's Encrypt
3. Gzip compression for better performance
4. Server header removal for security
5. Proper file handling with try_files

### Performance Optimizations
1. Gzip and Zstandard compression
2. Proper caching headers
3. Load balancer configuration
4. Reverse proxy setup

Remember to:
1. Ensure DNS is properly configured for your domain
2. Wait for SSL certificate generation (may take a few minutes)
3. Test both HTTP and HTTPS access
4. Verify all static assets are properly served
