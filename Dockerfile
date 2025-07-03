# Usa PHP-FPM oficial
FROM php:8.3-fpm

# 1. Instala nginx + utilidades + extensiones PHP
RUN apt-get update && apt-get install -y \
    nginx git curl zip unzip \
    libpng-dev libjpeg62-turbo-dev libfreetype6-dev \
    libonig-dev libxml2-dev libzip-dev \
    libicu-dev libcurl4-openssl-dev libssl-dev \
    netcat \
  && docker-php-ext-configure gd --with-freetype --with-jpeg \
  && docker-php-ext-install \
       pdo_mysql gd intl mbstring exif pcntl bcmath zip \
  && apt-get clean && rm -rf /var/lib/apt/lists/*

# 2. Instala Node.js 18 LTS
RUN curl -fsSL https://deb.nodesource.com/setup_18.x | bash - \
  && apt-get install -y nodejs \
  && apt-get clean && rm -rf /var/lib/apt/lists/*

# 3. Instala Composer
COPY --from=composer:2.6 /usr/bin/composer /usr/bin/composer

# 4. Copia tu código y establece permisos
WORKDIR /var/www
COPY . .
RUN chown -R www-data:www-data /var/www

# 5. Instala dependencias PHP + publica assets de Filament
RUN composer install --no-dev --optimize-autoloader \
 && php artisan vendor:publish --tag=filament-assets --force

# 6. Instala dependencias JS y compila Vite
RUN npm install && npm run build

# 7. Configura nginx: sirve /var/www/public
RUN rm /etc/nginx/sites-enabled/default
COPY default.conf /etc/nginx/conf.d/default.conf

# 8. Copia y da permisos al entrypoint
COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

# 9. Expone puerto estándar HTTP
EXPOSE 80

# 10. Lanza el entrypoint
ENTRYPOINT ["/entrypoint.sh"]
