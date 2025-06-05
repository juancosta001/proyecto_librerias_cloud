# Integrantes
Juan Acosta
José Gómez
Marcos Estigarribia

# 📚 Proyecto Librerías Cloud

Proyecto desarrollado para el segundo parcial de la materia **Cloud Computing**. Esta aplicación web permite gestionar una colección de libros, autores y editoriales, implementando funcionalidades CRUD completas.

## 🚀 Tecnologías utilizadas

- **Laravel**: Framework PHP para el backend.
- **Bootstrap**: Framework CSS para el diseño responsivo.
- **MySQL**: Sistema de gestión de bases de datos relacional.
- **Vite**: Herramienta de compilación para assets frontend.
- **Composer**: Gestión de dependencias PHP.
- **PHPUnit**: Framework de pruebas para PHP.

## ⚙️ Instalación y configuración

1. Clona el repositorio:

   ```bash
   git clone https://github.com/juancosta001/proyecto_librerias_cloud.git
   cd proyecto_librerias_cloud
   ```

2. Instala las dependencias de PHP y JavaScript:

   ```bash
   composer install
   npm install
   ```

3. Copia el archivo de entorno y configura las variables necesarias:

   ```bash
   cp .env.example .env
   ```

4. Modifica el archivo `.env`:

   - Cambia la base de datos de `sqlite` a `mysql`.
   - Cambia el valor de `DB_DATABASE` a `libreria`.
   - Descomenta las líneas de configuración de la base de datos (`DB_HOST`, `DB_PORT`, `DB_DATABASE`, `DB_USERNAME`, `DB_PASSWORD`) y asegúrate de configurarlas correctamente.

5. Genera la clave de la aplicación:

   ```bash
   php artisan key:generate
   ```

6. Ejecuta las migraciones para crear las tablas en la base de datos:

   ```bash
   php artisan migrate
   ```

7. Crea un usuario para acceder al sistema:

   ```bash
   php artisan db:seed
   ```

   Este comando ejecutará el seeder configurado que incluye la creación de un usuario predeterminado para el acceso inicial.



8. Inicia el servidor de desarrollo:

   ```bash
   php artisan serve
   ```

   La aplicación estará disponible en `http://localhost:8000/admin`.

## 📁 Estructura del proyecto

- `app/`: Contiene los controladores, modelos y lógica de negocio.
- `resources/views/`: Vistas Blade para la interfaz de usuario.
- `routes/web.php`: Definición de rutas web.
- `database/migrations/`: Archivos de migración para la base de datos.
- `database/seeders/`: Archivos para poblar la base de datos con datos iniciales.
- `public/`: Archivos públicos accesibles desde el navegador.
- `config/`: Archivos de configuración de la aplicación.

## 🧪 Pruebas

Para ejecutar las pruebas unitarias, utiliza el siguiente comando:

```bash
php artisan test
```

Asegúrate de haber configurado correctamente el entorno de pruebas en tu archivo `.env`.

## 📄 Licencia

Este proyecto está bajo la Licencia MIT. Consulta el archivo [LICENSE](LICENSE) para más detalles.
