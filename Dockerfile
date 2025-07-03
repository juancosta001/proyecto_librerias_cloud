FROM php:8.3-fpm

# 1. Instala dependencias del sistema
RUN apt-get update && apt-get install -y \
    git curl zip unzip \
    libpng-dev libjpeg-dev libfreetype6-dev \
    libonig-dev libxml2-dev libzip-dev \
    libicu-dev libcurl4-openssl-dev libssl-dev \
    netcat-traditional \
    && docker-php-ext-configure gd --with-freetype --with-jpeg \
    && docker-php-ext-install \
        pdo pdo_mysql mbstring exif pcntl bcmath gd zip intl \
    && apt-get clean && rm -rf /var/lib/apt/lists/*

# 2. Instala Node.js 18.x
RUN curl -fsSL https://deb.nodesource.com/setup_18.x | bash - \
    && apt-get install -y nodejs

# 3. Instala Composer
COPY --from=composer:2.6 /usr/bin/composer /usr/bin/composer

# 4. Define directorio de trabajo
WORKDIR /var/www

# 5. Copia TODO el proyecto primero
COPY . .

# 6. Instala Composer
RUN composer install --no-dev --optimize-autoloader

# 7. Publica los assets de Filament
RUN php artisan vendor:publish --tag=filament-assets --force

# 8. Compila frontend con Vite
RUN npm install && npm run build


# 8. Copia y da permisos al entrypoint
COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]

# 9. Permisos necesarios
RUN chown -R www-data:www-data storage bootstrap/cache \
    && chmod -R 775 storage bootstrap/cache

# 10. Expone puerto
EXPOSE 8080
