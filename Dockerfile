FROM php:8.3-fpm

# 1. Instala dependencias del sistema y extensiones PHP
RUN apt-get update && apt-get install -y \
    git curl zip unzip \
    libpng-dev libjpeg-dev libfreetype6-dev \
    libonig-dev libxml2-dev libzip-dev \
    libicu-dev libcurl4-openssl-dev libssl-dev \
    gnupg2 ca-certificates lsb-release \
    netcat \
    && docker-php-ext-configure gd --with-freetype --with-jpeg \
    && docker-php-ext-install \
        pdo pdo_mysql mbstring exif pcntl bcmath gd zip intl \
    && apt-get clean && rm -rf /var/lib/apt/lists/*

# 2. Instala Node.js (versión estable 18)
RUN curl -fsSL https://deb.nodesource.com/setup_18.x | bash - \
    && apt-get update && apt-get install -y nodejs

# 3. Instala Composer
COPY --from=composer:2.6 /usr/bin/composer /usr/bin/composer

# 4. Define el directorio de trabajo
WORKDIR /var/www

# 5. Copia el script de entrada
COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]

# 6. Copia archivos de Composer primero (para usar cache)
COPY composer.json composer.lock ./

# 7. Instala dependencias PHP
RUN composer install --no-dev --optimize-autoloader

# 8. Copia el resto del proyecto
COPY . .

# 9. Instala y compila assets (Vite)
RUN npm install && npm run build

# 10. Establece permisos de Laravel
RUN chown -R www-data:www-data storage bootstrap/cache \
    && chmod -R 775 storage bootstrap/cache

# 11. Expone el puerto que Laravel usará
EXPOSE 8000
