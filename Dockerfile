# Build stage for Node.js
FROM node:18-alpine as build-stage
WORKDIR /app
COPY package*.json ./
RUN npm install
COPY . .
RUN npm run build

# Production stage
FROM php:8.2-fpm-alpine

# Install system dependencies
RUN apk add --no-cache \
    nginx \
    supervisor \
    curl \
    libpng-dev \
    libzip-dev \
    zip \
    unzip \
    openssl

# Install PHP extensions
RUN docker-php-ext-install pdo_mysql zip exif pcntl gd

# Install composer
COPY --from=composer:latest /usr/bin/composer /usr/bin/composer

# Set working directory
WORKDIR /var/www

# Copy application files
COPY . /var/www/
COPY --from=build-stage /app/public/build /var/www/public/build

# Copy configuration files
COPY docker/nginx.conf /etc/nginx/http.d/default.conf
COPY docker/supervisord.conf /etc/supervisor/conf.d/supervisord.conf
COPY docker/php.ini /usr/local/etc/php/conf.d/custom.ini

# Install application dependencies
RUN composer install --no-dev --optimize-autoloader --no-interaction

# Set permissions
RUN chown -R www-data:www-data /var/www/storage /var/www/bootstrap/cache
RUN chmod -R 775 /var/www/storage /var/www/bootstrap/cache

# Create log directories
RUN mkdir -p /var/log/supervisor
RUN mkdir -p /var/log/nginx
RUN mkdir -p /var/log/php-fpm

# Set up Gzip compression
RUN echo "gzip on;" > /etc/nginx/conf.d/gzip.conf && \
    echo "gzip_types text/plain text/css application/json application/javascript text/xml application/xml application/xml+rss text/javascript;" >> /etc/nginx/conf.d/gzip.conf

# Add labels for Traefik
LABEL traefik.enable="true" \
    traefik.http.middlewares.gzip.compress="true" \
    traefik.http.middlewares.redirect-to-https.redirectscheme.scheme="https" \
    traefik.http.routers.http-0-awcc0ggoc088080gos4o04k8.entryPoints="http" \
    traefik.http.routers.http-0-awcc0ggoc088080gos4o04k8.middlewares="redirect-to-https" \
    traefik.http.routers.http-0-awcc0ggoc088080gos4o04k8.rule="Host(`wedding-kemash.nury.my.id`) && PathPrefix(`/`)" \
    traefik.http.routers.http-0-awcc0ggoc088080gos4o04k8.service="http-0-awcc0ggoc088080gos4o04k8" \
    traefik.http.routers.https-0-awcc0ggoc088080gos4o04k8.entryPoints="https" \
    traefik.http.routers.https-0-awcc0ggoc088080gos4o04k8.middlewares="gzip" \
    traefik.http.routers.https-0-awcc0ggoc088080gos4o04k8.rule="Host(`wedding-kemash.nury.my.id`) && PathPrefix(`/`)" \
    traefik.http.routers.https-0-awcc0ggoc088080gos4o04k8.service="https-0-awcc0ggoc088080gos4o04k8" \
    traefik.http.routers.https-0-awcc0ggoc088080gos4o04k8.tls.certresolver="letsencrypt" \
    traefik.http.routers.https-0-awcc0ggoc088080gos4o04k8.tls="true" \
    traefik.http.services.http-0-awcc0ggoc088080gos4o04k8.loadbalancer.server.port="9600" \
    traefik.http.services.https-0-awcc0ggoc088080gos4o04k8.loadbalancer.server.port="9600" \
    caddy_0.encode="zstd gzip" \
    caddy_0.handle_path.0_reverse_proxy="{{upstreams 9600}}" \
    caddy_0.handle_path="/*" \
    caddy_0.header="-Server" \
    caddy_0.try_files="{path} /index.html /index.php" \
    caddy_0="https://wedding-kemash.nury.my.id" \
    caddy_ingress_network="coolify"

# Expose port
EXPOSE 9600

# Start supervisor
CMD ["/usr/bin/supervisord", "-c", "/etc/supervisor/conf.d/supervisord.conf"]
