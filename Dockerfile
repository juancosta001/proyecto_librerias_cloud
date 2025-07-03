FROM php:8.3-fpm

# 1. Instala dependencias del sistema
RUN apt-get update && apt-get install -y \
    git curl zip unzip \
    libpng-dev libjpeg-dev libfreetype6-dev \
    libonig-dev libxml2-dev libzip-dev \
    libicu-dev \
    libcurl4-openssl-dev libssl-dev \
    nodejs npm \
    netcat \
    && docker-php-ext-configure gd --with-freetype --with-jpeg \
    && docker-php-ext-install pdo pdo_mysql mbstring exif pcntl bcmath gd zip intl


# 2. Instala Composer
COPY --from=composer:2.6 /usr/bin/composer /usr/bin/composer

# 3. Define el directorio de trabajo
WORKDIR /var/www

# 4. Copia el entrypoint antes de todo
COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]

# 5. Copia primero composer.* para aprovechar la cache
COPY composer.json composer.lock ./

# 6. Copia el resto del código fuente (incluye artisan y recursos)
COPY . .

# 7. Instala dependencias PHP
RUN composer install --no-dev --optimize-autoloader

# 8. Instala y compila assets Vite (frontend)
RUN npm install && npm run build

# 9. Permisos necesarios
RUN chown -R www-data:www-data storage bootstrap/cache \
    && chmod -R 775 storage bootstrap/cache

# 10. Expone puerto para Laravel
EXPOSE 8000
