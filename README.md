# Nuevo curso de *eduroam* para instituciones de Latino América

# Introducción (Falta completar)
Este curso esta dirigido a ...

# Configuración de las maquinas virtuales para el curso

Pre-requisito:


1. A través de la aplicación __putty__ em Windows o el terminal de comandos de Linux, cada usuario se deberá conectar al servidor Radius de su Institución.

2. Para los usuarios que no consigan conectarse remotamente a su servidor, podrán descargar su imagen en Docker el cual viene ya pre-configurado los paquetes necesarios para su uso. Algunas referencias de la instalación y configuración de Docker en Linux se muestra aqui: [docker](https://docs.docker.com/engine/installation/). Docker actualmente tiene soporte para Linux, Windows y MAC OS.

3. Instalar GIT desde aqui: [Git](https://help.github.com/articles/set-up-git/).

4. Las imágenes en Docker pueden ser descargadas desde aquí: 

..```
docker pull richardqa/curso-eduroam-radius1:v1
docker pull richardqa/curso-eduroam-radius2:v1
docker pull richardqa/curso-eduroam-proxy:v1

```
5. Para los usuarios que se conecten a su servidor remotamente, seguir los siguientes pasos:

git clone https://github.com/richardqa/curso-eduroam

cd curso-eduroam



