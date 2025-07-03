FROM php:8.3-fpm

# 1. Instala dependencias del sistema
RUN apt-get update && apt-get install -y \
    git curl zip unzip gnupg2 ca-certificates lsb-release \
    libpng-dev libjpeg-dev libfreetype6-dev \
    libonig-dev libxml2-dev libzip-dev \
    libicu-dev libssl-dev libcurl4-openssl-dev \
    netcat \
    && apt-get clean && rm -rf /var/lib/apt/lists/*

# 2. Instala Node.js (última LTS estable) y npm
RUN curl -fsSL https://deb.nodesource.com/setup_18.x | bash - \
    && apt-get update && apt-get install -y nodejs

# 3. Instala extensiones PHP necesarias
RUN docker-php-ext-configure gd --with-freetype --with-jpeg \
    && docker-php-ext-install pdo pdo_mysql mbstring exif pcntl bcmath gd zip intl

# 4. Instala Composer
COPY --from=composer:2.6 /usr/bin/composer /usr/bin/composer

# 5. Define el directorio de trabajo
WORKDIR /var/www

# 6. Copia el entrypoint antes de todo
COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]

# 7. Copia composer.* primero y luego instalar dependencias PHP
COPY composer.json composer.lock ./
RUN composer install --no-dev --optimize-autoloader

# 8. Copia el resto del código fuente (incluye artisan, routes, etc)
COPY . .

# 9. Compila assets con Vite
RUN npm install && npm run build

# 10. Asigna permisos adecuados
RUN chown -R www-data:www-data storage bootstrap/cache \
    && chmod -R 775 storage bootstrap/cache

# 11. Expone el puerto de Laravel
EXPOSE 8000
