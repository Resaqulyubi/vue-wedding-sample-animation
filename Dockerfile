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
    supervisor \
    && docker-php-ext-install pdo_pgsql \
    && docker-php-ext-configure gd --with-freetype --with-jpeg \
    && docker-php-ext-install gd \
    && docker-php-ext-install zip

# Create necessary directories and set permissions
RUN mkdir -p /var/log/supervisor /var/log/nginx /var/log/php-fpm \
    && chown -R www-data:www-data /var/log/supervisor /var/log/nginx /var/log/php-fpm

# Copy application files and configurations
COPY --chown=www-data:www-data . /var/www/html
COPY docker/nginx.conf /etc/nginx/conf.d/default.conf
COPY docker/supervisord.conf /etc/supervisor/conf.d/supervisord.conf
COPY docker/php.ini /usr/local/etc/php/conf.d/custom.ini
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
RUN npm install && npm run build

USER root
CMD ["/usr/bin/supervisord", "-c", "/etc/supervisor/conf.d/supervisord.conf"]

EXPOSE 9600
