# Imagen base oficial de PHP con FPM
FROM php:8.2-fpm

# Instala dependencias del sistema
RUN apt-get update && apt-get install -y \
    git curl zip unzip \
    libpng-dev libjpeg-dev libfreetype6-dev \
    libonig-dev libxml2-dev libzip-dev \
    libcurl4-openssl-dev libssl-dev \
    && docker-php-ext-configure gd --with-freetype --with-jpeg \
    && docker-php-ext-install pdo pdo_mysql mbstring exif pcntl bcmath gd zip

# Instala Composer
COPY --from=composer:2.6 /usr/bin/composer /usr/bin/composer

# Define el directorio de trabajo
WORKDIR /var/www

# Copia todos los archivos al contenedor
COPY . .

# Instala dependencias de Laravel
RUN composer install --no-dev --optimize-autoloader

# Da permisos a las carpetas necesarias
RUN chown -R www-data:www-data storage bootstrap/cache

# Establece permisos para producción
RUN chmod -R 775 storage bootstrap/cache

# Expone el puerto 8000
EXPOSE 8000

# Comando para iniciar el servidor de Laravel
CMD php artisan serve --host=0.0.0.0 --port=8000
