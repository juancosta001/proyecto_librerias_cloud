#!/bin/bash

set -e

echo "⏳ Esperando conexión con la base de datos en $DB_HOST:$DB_PORT..."
timeout=60
elapsed=0

while ! nc -z "$DB_HOST" "$DB_PORT"; do
  if [ $elapsed -ge $timeout ]; then
    echo "❌ Tiempo de espera agotado. No se pudo conectar a la base de datos."
    exit 1
  fi
  echo "⌛ Esperando... ($elapsed s)"
  sleep 3
  elapsed=$((elapsed + 3))
done

echo "✅ Base de datos disponible. Ejecutando migraciones..."

php artisan migrate --force

echo "🌱 Ejecutando seeders..."
php artisan db:seed --force

echo "🚀 Iniciando servidor Laravel en el puerto 8000..."
exec php artisan serve --host=0.0.0.0 --port=8000
