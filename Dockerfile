FROM php:8.3-fpm

# 1. Actualiza e instala utilidades base
RUN apt-get update && apt-get install -y \
    git curl zip unzip \
    libpng-dev libjpeg-dev libfreetype6-dev \
    libonig-dev libxml2-dev libzip-dev \
    libicu-dev libcurl4-openssl-dev libssl-dev \
    netcat

# 2. Configura e instala extensiones de PHP
RUN docker-php-ext-configure gd --with-freetype --with-jpeg \
    && docker-php-ext-install pdo pdo_mysql mbstring exif pcntl bcmath gd zip intl

# 3. Instala Node.js 18 (Vite necesita versión moderna)
RUN curl -fsSL https://deb.nodesource.com/setup_18.x | bash - \
    && apt-get install -y nodejs

# 4. Instala Composer
COPY --from=composer:2.6 /usr/bin/composer /usr/bin/composer

# 5. Define el directorio de trabajo
WORKDIR /var/www

# 6. Copia el entrypoint y da permisos
COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]

# 7. Copia composer antes para aprovechar caché
COPY composer.json composer.lock ./

# 8. Copia el resto del proyecto
COPY . .

# 9. Instala dependencias PHP
RUN composer install --no-dev --optimize-autoloader

# 10. Compila Vite
RUN npm install && npm run build

# 11. Permisos de Laravel
RUN chown -R www-data:www-data storage bootstrap/cache \
    && chmod -R 775 storage bootstrap/cache

# 12. Expone el puerto Laravel
EXPOSE 8000
