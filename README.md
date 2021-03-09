#  MELIChallenge
## App challenge para desarrollador iOS de Mercado Libre

### Cada pantalla deberíamos poder rotarla y debería mantenerse el estado de la vista.

Realizado, sin comentarios.

### Test unitarios de la lógica del proyecto.

Siendo un proyecto sin mucha lógica de negocios, se realizaron pocos test unitarios en forma de ejemplo.
Se realizaron test de llamado al servicio y un simple test de chequeo de un texto.

### Fundamentos de elección de dependencias de terceros en caso de usarlas.

Se utilizó Swift Package Dependencies para agregar libreria de terceros. 
La única que se agrego fue SDWebImage (https://github.com/SDWebImage/SDWebImage) para la descarga de las imágenes asincronicamente y utilizar caché. 

### Manejo de casos de error desde el punto de vista del developer. 
### Cómo se gestionan los casos de error inesperados, la consistencia a lo largo de toda la app, uso de logs, etc.

Para logueo de errores post puesta en producción se podría utilizar Firebase o Crashlytics.

### Manejo de casos de error desde el punto de vista del usuario.
### Priorizar una experiencia fluida dando feedback al usuario adecuadamente.

El único error visible para el usuario seria el de falta de conexión a internet. Tambien se manejo la posibilidad de no encontrar resultados en la busqueda, no es 
un error, pero mejora la experiencia de usuario. 

## Cosas a mejorar

- Paginado de resultados de busqueda 
- Mejorar la pantalla de detalles

