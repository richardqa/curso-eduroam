# Nuevo curso de *eduroam* para las Instituciones de la Red Académica de Uruguay (RAU)

# Introducción
Este curso esta dirigido a los administradores de redes de las instituciones académicas de Latino América.

# Objetivo
Capacitar a los administradores de redes de instituciones académicas en la instalación, configuración y mantenimiento de los servidores RADIUS. También en el mantenimiento del sistema de monitoreo de usuarios usando la herramienta F-Ticks.

<a href="http://www.youtube.com/watch?feature=player_embedded&v=qk9aljqu20A
" target="_blank"><img src="https://github.com/richardqa/curso-eduroam/blob/master/imagenes/eduroam1.png" 
alt="IMAGE ALT TEXT HERE" width="480" height="360" border="10" /></a>

# Configuración de las maquinas virtuales para el curso

Pre-requisito:


1. A través de la aplicación __putty__ em Windows o el terminal de comandos de Linux, cada usuario se deberá conectar al servidor Radius de su Institución.

2. Para los usuarios que no consigan conectarse remotamente a su servidor, podrán descargar su imagen en Docker el cual viene ya pre-configurado los paquetes necesarios para su uso. Algunas referencias de la instalación y configuración de Docker en Linux se muestra aqui: [docker](https://docs.docker.com/engine/installation/). Docker actualmente tiene soporte para Linux, Windows y MAC OS.

3. Instalar GIT desde aqui: [Git](https://help.github.com/articles/set-up-git/).

4. Las imágenes en Docker pueden ser descargadas desde aquí: 

 ```
docker pull richardqa/curso-eduroam-radius1:v1
docker pull richardqa/curso-eduroam-radius2:v1
docker pull richardqa/curso-eduroam-proxy:v1

 ```
5. Para los usuarios que se conecten a su servidor remotamente, seguir los siguientes pasos:

 ```
git clone https://github.com/richardqa/curso-eduroam
cd curso-eduroam
 ```
Para instalar los paquetes necesarios para la configuración del servidor Radius:
 ```
bash scripts/inicio.sh
 ```
6. Para los siguientes pasos seguir al [modulo1](https://github.com/richardqa/curso-eduroam/blob/master/modulos/actividad1.md).







