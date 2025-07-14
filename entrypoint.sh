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
if [ ! -f .env ]; then
  cp .env.example .env 2>/dev/null || touch .env
fi
if ! grep -q '^APP_KEY=' .env; then
  php artisan key:generate --force
fi

# 3) Cache config, rutas y migraciones
php artisan config:cache
php artisan route:cache
php artisan migrate --force || true
php artisan db:seed --force || true

# 4) Levanta PHP-FPM en background y luego nginx en foreground
echo "🚀 Arrancando php-fpm..."
php-fpm -D

echo "🚀 Arrancando nginx..."
nginx -g 'daemon off;'
