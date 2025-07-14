FROM php:8.3-fpm

# 1. Instala nginx + utilidades + dependencias para PHP y Node.js
RUN apt-get update && apt-get install -y \
    nginx \
    git curl zip unzip \
    libpng-dev libjpeg-dev libfreetype6-dev \
    libonig-dev libxml2-dev libzip-dev \
    libicu-dev libcurl4-openssl-dev libssl-dev \
    netcat-traditional \
    gnupg2 ca-certificates lsb-release \
  && docker-php-ext-configure gd --with-freetype --with-jpeg \
  && docker-php-ext-install \
       pdo_mysql gd intl mbstring exif pcntl bcmath zip \
  && apt-get clean && rm -rf /var/lib/apt/lists/*

# 2. Installer Node.js 18.x
RUN curl -fsSL https://deb.nodesource.com/setup_18.x | bash - \
  && apt-get update && apt-get install -y nodejs \
  && apt-get clean && rm -rf /var/lib/apt/lists/*

# 3. Copia Composer
COPY --from=composer:2.6 /usr/bin/composer /usr/bin/composer

# 4. Copia el proyecto y ajusta permisos
WORKDIR /var/www
COPY . .
RUN chown -R www-data:www-data /var/www

# 5. Instala deps PHP y publica assets de Filament
RUN composer install --no-dev --optimize-autoloader \
 && php artisan vendor:publish --tag=filament-assets --force

# 6. Instala deps JS y compila con Vite
RUN npm install && npm run build

# 7. Configura nginx: sirve /var/www/public
RUN rm /etc/nginx/sites-enabled/default
COPY default.conf /etc/nginx/conf.d/default.conf

# 8. Copia entrypoint
COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

# 9. Expone el puerto que usa Railway ($PORT / 8080)
EXPOSE 8080

# 10. Lanza entrypoint
ENTRYPOINT ["/entrypoint.sh"]
