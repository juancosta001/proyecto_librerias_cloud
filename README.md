- **Repositorio de GitHub**: [https://github.com/juancosta001/proyecto_librerias_cloud](https://github.com/juancosta001/proyecto_librerias_cloud)
# Integrantes
Juan Acosta
José Gómez 
Marcos Estigarribia

# Enlace de Acceso
https://proyectolibreriascloud-production.up.railway.app/admin/login

# Tareas Realizadas

-Juan Acosta: Encargado de Levantar el proyecto,definición de tecnologías, definición de tablas, creación de crud,encargado de realizar el despliegue automatizado
-José Gómez: Encargado de crear el crud de Categorias,realizo pull request, encargado del readme.md
-Marcos Estigarribia: Asignamiento de roles,creación del tablero trello


# 📚 Proyecto Librerías Cloud

Proyecto desarrollado para el segundo parcial de la materia **Cloud Computing**. Esta aplicación web permite gestionar una colección de libros, autores y editoriales, implementando funcionalidades CRUD completas.

## 🚀 Tecnologías utilizadas

- **Laravel**: Framework PHP para el backend.
- **Bootstrap**: Framework CSS para el diseño responsivo.
- **MySQL**: Sistema de gestión de bases de datos relacional.
- **Vite**: Herramienta de compilación para assets frontend.
- **Composer**: Gestión de dependencias PHP.
- **PHPUnit**: Framework de pruebas para PHP.

## ⚙️ Instalación local y configuración

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

## En caso de acceso en la página web
1. Ingresar a https://proyectolibreriascloud-production.up.railway.app/admin/login
2. Ingresar con el usuario por defecto, admin@gmail.com y admin.
3. Ya se puede ingresar y manipular el CRUD para librerías.

## 📁 Estructura del proyecto

- `app/`: Contiene los controladores, modelos y lógica de negocio.
- `resources/views/`: Vistas Blade para la interfaz de usuario.
- `routes/web.php`: Definición de rutas web.
- `database/migrations/`: Archivos de migración para la base de datos.
- `database/seeders/`: Archivos para poblar la base de datos con datos iniciales.
- `public/`: Archivos públicos accesibles desde el navegador.
- `config/`: Archivos de configuración de la aplicación.


Asegúrate de haber configurado correctamente el entorno de pruebas en tu archivo `.env`.

# Despliegue

## Despliegue en Railway

El proyecto está desplegado en **Railway**, donde se utiliza Docker para contenerizar la aplicación y nginx para servir tanto la aplicación web como los archivos estáticos. El proceso de despliegue se ejecuta automáticamente cada vez que se realiza un commit a la rama `main` del repositorio. La aplicación se despliega en una cápsula separada para el backend y otra para la base de datos.

### Pasos para el despliegue:

1. **Docker**: 
   La aplicación se ejecuta dentro de un contenedor Docker. El contenedor incluye todos los servicios necesarios para ejecutar el proyecto (PHP, Nginx, Node.js y base de datos MySQL).
   
2. **Nginx y PHP-FPM**:
   Utilizamos **nginx** como servidor web y **PHP-FPM** para procesar las solicitudes PHP. El archivo de configuración de nginx se encuentra en `default.conf` y se encarga de servir los archivos estáticos generados por Vite y de manejar las rutas dinámicas a través de Laravel.

3. **Dockerfile**:
   El `Dockerfile` se configura para instalar las dependencias necesarias, compilar los archivos de frontend (con Vite), ejecutar las migraciones y publicar los assets de Filament, y finalmente arrancar el servidor con Nginx y PHP-FPM.

4. **Automatización del despliegue**:
   Cada vez que se realiza un commit a la rama `main`, Railway ejecuta el flujo de despliegue que construye el contenedor, publica los cambios y lanza la nueva versión de la aplicación. 

# Capturas de pantalla de la ejecución o despliegue

# Build logs
<img width="1036" height="896" alt="Captura desde 2025-07-13 14-30-31" src="https://github.com/user-attachments/assets/3a4c5303-b0d8-48ed-a2ec-130f0478d05f" />
_Log de construcción del proyecto_

# Deploy logs
<img width="1036" height="896" alt="Captura desde 2025-07-13 14-31-14" src="https://github.com/user-attachments/assets/66f0fb2a-b8e1-4dac-9306-da58975c3f02" />
_Log de despliegue del contenedor_

# Historial de despliegue

<img width="1036" height="896" alt="Captura desde 2025-07-13 14-33-00" src="https://github.com/user-attachments/assets/bce975a6-1b7a-4c06-9ecd-1a4e61ae7e13" />
_Historial de versiones desplegadas en Railway_

# Contenedor con la base de datos
<img width="1036" height="896" alt="Captura desde 2025-07-13 14-33-27" src="https://github.com/user-attachments/assets/80f47599-54b6-4263-a9d3-522849d3179b" />
_Vista del contenedor de la base de datos en Railway_

## 📄 Licencia

Este proyecto está bajo la Licencia MIT. Consulta el archivo [LICENSE](LICENSE) para más detalles.
