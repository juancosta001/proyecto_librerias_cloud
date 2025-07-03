FROM php:8.3-fpm

# 1. Instala dependencias del sistema + nginx
RUN apt-get update && apt-get install -y \
    nginx \
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
  && apt-get install -y nodejs \
  && apt-get clean && rm -rf /var/lib/apt/lists/*

# 3. Instala Composer
COPY --from=composer:2.6 /usr/bin/composer /usr/bin/composer

# 4. Copia código y configura permisos
WORKDIR /var/www
COPY . .
RUN chown -R www-data:www-data /var/www

# 5. Instala deps PHP y publica assets
RUN composer install --no-dev --optimize-autoloader \
 && php artisan vendor:publish --tag=filament-assets --force

# 6. Compila con Vite
RUN npm install && npm run build

# 7. Copia y habilita entrypoint
COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

# 8. Configura nginx:  
#   sustituyes el default.conf con uno que sirva /var/www/public
RUN rm /etc/nginx/sites-enabled/default \
 && printf 'server {\n\
    listen  8080;\n\
    root   /var/www/public;\n\
    index  index.php index.html;\n\
    location / {\n\
      try_files $uri $uri/ /index.php?$query_string;\n\
    }\n\
    location ~ \.php$ {\n\
      fastcgi_pass   unix:/var/run/php/php8.3-fpm.sock;\n\
      fastcgi_index  index.php;\n\
      include        fastcgi_params;\n\
      fastcgi_param  SCRIPT_FILENAME $document_root$fastcgi_script_name;\n\
    }\n\
    location ~* \.(css|js|png|jpg|jpeg|gif|svg|woff2?|ttf|eot)$ {\n\
      expires 1y;\n\
      add_header Cache-Control \"public\";\n\
    }\n\
}\n' > /etc/nginx/conf.d/default.conf

# 9. Exponer puerto
EXPOSE 8080

# 10. Lanza entrypoint
ENTRYPOINT ["/entrypoint.sh"]
