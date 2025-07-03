FROM php:8.3-fpm

# 1. Instala dependencias del sistema (sin Node todavía)
RUN apt-get update && apt-get install -y \
    git curl zip unzip \
    libpng-dev libjpeg-dev libfreetype6-dev \
    libonig-dev libxml2-dev libzip-dev \
    libicu-dev \
    libcurl4-openssl-dev libssl-dev \
    netcat \
    && docker-php-ext-configure gd --with-freetype --with-jpeg \
    && docker-php-ext-install pdo pdo_mysql mbstring exif pcntl bcmath gd zip intl

# 2. Instala Node.js 18 LTS (para Vite)
RUN curl -fsSL https://deb.nodesource.com/setup_18.x | bash - \
    && apt-get install -y nodejs

# 3. Instala Composer
COPY --from=composer:2.6 /usr/bin/composer /usr/bin/composer

# 4. Define el directorio de trabajo
WORKDIR /var/www

# 5. Copia entrypoint y da permisos
COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]

# 6. Copia archivos de Composer (para aprovechar caché)
COPY composer.json composer.lock ./

# 7. Copia todo el código fuente (incluye artisan y recursos)
COPY . .

# 8. Instala dependencias PHP
RUN composer install --no-dev --optimize-autoloader

# 9. Instala y compila assets Vite
RUN npm install && npm run build

# 10. Permisos requeridos por Laravel
RUN chown -R www-data:www-data storage bootstrap/cache \
    && chmod -R 775 storage bootstrap/cache

# 11. Exponer el puerto del servidor Laravel
EXPOSE 8000
