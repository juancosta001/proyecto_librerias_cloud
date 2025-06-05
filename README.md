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

   Modifica el archivo `.env` con tus credenciales de base de datos y otras configuraciones.

4. Genera la clave de la aplicación:

   ```bash
   php artisan key:generate
   ```

5. Ejecuta las migraciones para crear las tablas en la base de datos:

   ```bash
   php artisan migrate
   ```

6. Compila los assets frontend:

   ```bash
   npm run dev
   ```

7. Inicia el servidor de desarrollo:

   ```bash
   php artisan serve
   ```

   La aplicación estará disponible en `http://localhost:8000`.

## 📁 Estructura del proyecto

- `app/`: Contiene los controladores, modelos y lógica de negocio.
- `resources/views/`: Vistas Blade para la interfaz de usuario.
- `routes/web.php`: Definición de rutas web.
- `database/migrations/`: Archivos de migración para la base de datos.
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
