#!/bin/sh

cd /var/www

# Esperar a que MySQL esté listo
echo "⏳ Esperando conexión con la base de datos en ${DB_HOST}:${DB_PORT}..."
while ! nc -z "$DB_HOST" "$DB_PORT"; do
  sleep 3
done
echo "✅ Base de datos disponible. Continuando..."

# Crear .env si no existe
if [ ! -f ".env" ]; then
  echo "⚙️  Generando .env automáticamente..."

  cp .env.example .env 2>/dev/null || touch .env

  # Asegurar que APP_KEY se genere solo si no está seteada
  if ! grep -q "APP_KEY=" .env; then
    echo "🔑 Generando APP_KEY automáticamente..."
    php artisan key:generate
  fi
fi

# Iniciar el servidor
php artisan config:cache
php artisan route:cache
php artisan migrate --force || true
php artisan db:seed --force || true


echo "🚀 Iniciando Laravel HTTP server..."
php -d variables_order=EGPCS -S 0.0.0.0:8080 -t public
