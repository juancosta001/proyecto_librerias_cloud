#!/bin/bash

set -e

# Espera hasta que la base de datos esté lista
# Espera un máximo de 60 segundos a que la DB esté disponible
timeout=60
elapsed=0

echo "⏳ Esperando a la base de datos en $DB_HOST:$DB_PORT..."

until nc -z "$DB_HOST" "$DB_PORT"; do
  if [ $elapsed -ge $timeout ]; then
    echo "❌ Tiempo de espera agotado. No se pudo conectar a la base de datos."
    exit 1
  fi
  echo "⏱️ Esperando..."
  sleep 3
  elapsed=$((elapsed+3))
done

echo "✅ Conexión a la base de datos exitosa."


echo "✔️ Base de datos disponible. Continuando..."

# Ejecuta migraciones
echo "🔁 Ejecutando migraciones..."
php artisan migrate --force

# Ejecuta seeders (opcional, comenta si no usás)
echo "🌱 Ejecutando seeders..."
php artisan db:seed --force

# Compila assets con Vite (ya lo hiciste en Dockerfile, así que esto está comentado)
# npm install && npm run build

# Inicia el servidor Laravel
echo "🚀 Iniciando servidor Laravel en puerto 8000..."
exec php artisan serve --host=0.0.0.0 --port=8000
