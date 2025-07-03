#!/bin/bash

set -e

# Espera a que la base de datos esté lista
echo "⏳ Esperando conexión con la base de datos en $DB_HOST:$DB_PORT..."
until nc -z "$DB_HOST" "$DB_PORT"; do
  echo "❗ Aún no disponible. Reintentando en 3s..."
  sleep 3
done

echo "✅ Base de datos disponible. Continuando..."

# Generar clave de aplicación si no existe
if [ -z "$APP_KEY" ] || ! grep -q "^APP_KEY=" .env; then
  echo "🔐 Generando APP_KEY automáticamente..."
  php artisan key:generate --force
fi

# Ejecutar migraciones
echo "🔁 Ejecutando migraciones..."
php artisan migrate --force

# (Opcional) Ejecutar seeders
echo "🌱 Ejecutando seeders..."
php artisan db:seed --force || echo "ℹ️ No se ejecutaron seeders o ya están aplicados."

# Iniciar servidor Laravel
echo "🚀 Iniciando servidor Laravel en puerto 8080..."
exec php artisan serve --host=0.0.0.0 --port=8000
