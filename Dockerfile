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
ENV NGINX_PHP_FPM_TIMEOUT=300s

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
    nginx \
    && docker-php-ext-install pdo_pgsql \
    && docker-php-ext-configure gd --with-freetype --with-jpeg \
    && docker-php-ext-install gd \
    && docker-php-ext-install zip

# Create necessary directories and set permissions
RUN mkdir -p /var/log/supervisor /var/log/nginx /var/log/php-fpm /run/nginx \
    && chown -R www-data:www-data /var/log/supervisor /var/log/nginx /var/log/php-fpm \
    && chmod -R 755 /var/log/supervisor /var/log/nginx /var/log/php-fpm

# Copy application files and configurations
COPY --chown=www-data:www-data . /var/www/html

# Copy nginx configurations
COPY docker/nginx/nginx.conf /etc/nginx/nginx.conf
COPY docker/nginx.conf /etc/nginx/conf.d/default.conf

# Copy PHP-FPM configuration
COPY docker/php/www.conf /usr/local/etc/php-fpm.d/www.conf
COPY docker/php.ini /usr/local/etc/php/conf.d/custom.ini

# Copy supervisor configuration
COPY docker/supervisord.conf /etc/supervisor/conf.d/supervisord.conf

# Create custom error page
RUN echo '<html><body><h1>502 Bad Gateway</h1><p>The application is currently unavailable. Please try again later.</p></body></html>' > /var/www/html/public/502.html

# Set working directory
WORKDIR /var/www/html

# Ensure proper permissions and create build directory
RUN mkdir -p public/build \
    && chown -R www-data:www-data . \
    && chmod -R 775 . \
    && chmod -R 775 public/build \
    && chown -R www-data:www-data public/build

USER www-data

# Install PHP dependencies
RUN composer install --no-interaction --optimize-autoloader --no-dev

# Install and build frontend assets
RUN npm ci
RUN npm run build

USER root

# Enable error logging for PHP
RUN echo "log_errors = On" >> /usr/local/etc/php/conf.d/error-logging.ini && \
    echo "error_log = /var/log/php-fpm/php-error.log" >> /usr/local/etc/php/conf.d/error-logging.ini

# Verify nginx configuration
RUN nginx -t

CMD ["/usr/bin/supervisord", "-c", "/etc/supervisor/conf.d/supervisord.conf"]

EXPOSE 9600
