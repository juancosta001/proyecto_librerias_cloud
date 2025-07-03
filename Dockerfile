FROM php:8.3-fpm

# 1. Instala dependencias del sistema
RUN apt-get update && apt-get install -y \
    git curl zip unzip \
    libpng-dev libjpeg-dev libfreetype6-dev \
    libonig-dev libxml2-dev libzip-dev \
    libicu-dev libcurl4-openssl-dev libssl-dev \
    gnupg2 ca-certificates lsb-release \
    nodejs npm netcat \
    && docker-php-ext-configure gd --with-freetype --with-jpeg \
    && docker-php-ext-install pdo pdo_mysql mbstring exif pcntl bcmath gd zip intl \
    && apt-get clean && rm -rf /var/lib/apt/lists/*

# 2. Instala Composer (desde contenedor oficial)
COPY --from=composer:2.6 /usr/bin/composer /usr/bin/composer

# 3. Define el directorio de trabajo
WORKDIR /var/www

# 4. Copia el entrypoint antes de todo
COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]

# 5. Copia primero los archivos de Composer para aprovechar cache
COPY composer.json composer.lock ./

# 6. Instala dependencias PHP (sin dev para producción)
RUN composer install --no-dev --optimize-autoloader

# 7. Copia el resto del código fuente (artisan incluido)
COPY . .

# 8. Compila assets con Vite
RUN npm install && npm run build

# 9. Permisos necesarios para Laravel
RUN chown -R www-data:www-data storage bootstrap/cache \
    && chmod -R 775 storage bootstrap/cache

# 10. Expone puerto para Laravel
EXPOSE 8000
