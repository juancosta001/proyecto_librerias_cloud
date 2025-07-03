FROM php:8.3-fpm

# Instala dependencias del sistema necesarias para PHP y Laravel
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

# Instala Node.js 18.x
RUN curl -fsSL https://deb.nodesource.com/setup_18.x | bash - \
    && apt-get update && apt-get install -y nodejs \
    && apt-get clean && rm -rf /var/lib/apt/lists/*

# Instala Composer
COPY --from=composer:2.6 /usr/bin/composer /usr/bin/composer

# Define el directorio de trabajo
WORKDIR /var/www

# Copia el entrypoint antes de todo
COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]

# Copia solo los archivos composer primero para usar cache
COPY composer.json composer.lock ./

# Instala dependencias PHP
RUN composer install --no-dev --optimize-autoloader

# Copia el resto del proyecto
COPY . .

# Compila assets con Vite
RUN npm install && npm run build

# Asigna permisos a Laravel
RUN chown -R www-data:www-data storage bootstrap/cache \
    && chmod -R 775 storage bootstrap/cache

# Expone el puerto de Laravel
EXPOSE 8000
