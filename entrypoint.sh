#!/bin/sh
set -e

cd /var/www

# 1) Espera a la base de datos
echo "⏳ Esperando DB en $DB_HOST:$DB_PORT..."
until nc -z "$DB_HOST" "$DB_PORT"; do
  sleep 2
done
echo "✅ DB disponible"

# 2) Genera .env y APP_KEY si faltan
if [ ! -f ".env" ]; then
  cp .env.example .env || touch .env
fi
if ! grep -q '^APP_KEY=' .env; then
  php artisan key:generate --force
fi

# 3) Cache config y migraciones
php artisan config:cache
php artisan route:cache
php artisan migrate --force || true
php artisan db:seed --force || true

# 4) Arranca PHP-FPM en background y Nginx en foreground
php-fpm -D
echo "🚀 Iniciando nginx + php-fpm en puerto 8080..."
nginx -g 'daemon off;'
