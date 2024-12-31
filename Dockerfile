# Build stage for Node.js
FROM node:18-alpine as build-stage
WORKDIR /app
COPY package*.json ./
RUN npm install
COPY . .
RUN npm run build

# Production stage
FROM serversideup/php:8.2-fpm-nginx

ENV PHP_OPCACHE_ENABLE=1
ENV NGINX_ROOT=/var/www/html/public
ENV NGINX_CLIENT_MAX_BODY_SIZE=100M
ENV NGINX_PHP_FPM_TIMEOUT=60s

USER root

# Install Node.js and system dependencies
RUN curl -sL https://deb.nodesource.com/setup_20.x | bash -
RUN apt-get update && apt-get install -y \
    nodejs \
    libpq-dev \
    libfreetype6-dev \
    libjpeg62-turbo-dev \
    libpng-dev \
    libzip-dev \
    && docker-php-ext-install pdo_pgsql \
    && docker-php-ext-configure gd --with-freetype --with-jpeg \
    && docker-php-ext-install gd \
    && docker-php-ext-install zip

# Create necessary directories and set permissions
RUN mkdir -p /var/log/supervisor /var/log/nginx /var/log/php-fpm \
    && chown -R www-data:www-data /var/log/supervisor /var/log/nginx /var/log/php-fpm

# Copy application files
COPY --chown=www-data:www-data . /var/www/html
COPY --from=build-stage /app/public/build /var/www/html/public/build

# Set working directory
WORKDIR /var/www/html

# Set proper permissions
RUN chown -R www-data:www-data /var/www/html/storage /var/www/html/bootstrap/cache \
    && chmod -R 775 /var/www/html/storage /var/www/html/bootstrap/cache

# Switch to www-data user for application operations
USER www-data

# Install dependencies and build assets
RUN composer install --no-interaction --optimize-autoloader --no-dev

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
    traefik.http.services.http-0-awcc0ggoc088080gos4o04k8.loadbalancer.server.port="80" \
    traefik.http.services.https-0-awcc0ggoc088080gos4o04k8.loadbalancer.server.port="80" \
    caddy_0.encode="zstd gzip" \
    caddy_0.handle_path.0_reverse_proxy="{{upstreams 80}}" \
    caddy_0.handle_path="/*" \
    caddy_0.header="-Server" \
    caddy_0.try_files="{path} /index.html /index.php" \
    caddy_0="https://wedding-kemash.nury.my.id" \
    caddy_ingress_network="coolify"

# Expose port
EXPOSE 80

# Start supervisor
CMD ["/usr/bin/supervisord", "-c", "/etc/supervisor/conf.d/supervisord.conf"]
