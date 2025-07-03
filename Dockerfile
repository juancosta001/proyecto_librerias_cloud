FROM php:8.3-fpm

# Instala dependencias del sistema
RUN apt-get update && apt-get install -y \
    git curl zip unzip \
    libpng-dev libjpeg-dev libfreetype6-dev \
    libonig-dev libxml2-dev libzip-dev \
    libicu-dev \
    libcurl4-openssl-dev libssl-dev \
    nodejs npm \
    && docker-php-ext-configure gd --with-freetype --with-jpeg \
    && docker-php-ext-install pdo pdo_mysql mbstring exif pcntl bcmath gd zip intl

# Instala Composer
COPY --from=composer:2.6 /usr/bin/composer /usr/bin/composer

# Define el directorio de trabajo
WORKDIR /var/www

# Copia el código fuente
COPY . .

# Asigna permisos generales
RUN chown -R www-data:www-data /var/www

# Instala dependencias PHP
RUN composer install --no-dev --optimize-autoloader

# Instala dependencias JS y compila assets (Vite)
RUN npm install && npm run build

# Permisos para Laravel
RUN chown -R www-data:www-data storage bootstrap/cache \
    && chmod -R 775 storage bootstrap/cache

# Exponer el puerto
EXPOSE 8000

# Comando principal
CMD php artisan serve --host=0.0.0.0 --port=8000
