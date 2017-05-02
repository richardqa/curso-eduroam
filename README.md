# Nuevo curso de *eduroam* para instituciones académicas de Latino América

# Introducción
Este curso esta dirigido a los administradores de redes de las instituciones académicas de Latino América.

# Objetivo
Capacitar a los administradores de redes de instituciones académicas en la instalación, configuración y mantenimiento de los servidores RADIUS. También en el mantenimiento del sistema de monitoreo de usuarios usando la herramienta F-Ticks.

<a href="http://www.youtube.com/watch?feature=player_embedded&v=qk9aljqu20A
" target="_blank"><img src="https://github.com/richardqa/curso-eduroam/blob/master/imagenes/eduroam1.png" 
alt="IMAGE ALT TEXT HERE" width="480" height="360" border="10" /></a>

# Pasos previos para la configuración del servidor Radius

Pre-requisitos:

1. Éste curso esta desarrollado para ser implementado en Ubuntu 16.04 LTS ó contenedor Docker. 

2. Cada usuario podrá conectarse remotamente a su servidor Local de su institución, ó podrá descargar las imágenes pre-configuradas en Docker importando los siguientes enlaces:
 
 ```
docker pull richardqa/curso-eduroam-radius1:v1
docker pull richardqa/curso-eduroam-radius2:v1
docker pull richardqa/curso-eduroam-proxy:v1

 ```
3. El acceso a los servidores podrán ser realizados a través de la aplicación [Putty](http://www.putty.org/) para Windows o el terminal de comandos para Linux, cada usuario se deberá conectar al servidor Radius de su institución remotamente ó a través del programa *Docker*

	- Instalación y configuración de Docker en Linux [docker](https://docs.docker.com/engine/installation/). Docker actualmente tiene soporte para Linux, Windows y MAC OS.
 	- Instalación de [Git](https://help.github.com/articles/set-up-git/)

4. Para los usuarios que se conecten a su servidor remotamente, seguir directamente los siguientes pasos:

 ```
git clone https://github.com/richardqa/curso-eduroam
cd curso-eduroam
 ```
Para instalar los paquetes necesarios para la configuración del servidor Radius:
 ```
bash scripts/inicio.sh
 ```
5. Para la configuración de los certificados digitales X509, ir al [modulo1](https://github.com/richardqa/curso-eduroam/blob/master/modulos/actividad1.md).

6. Para la configuración de claves públicas y privadas usando GPG, ir al [modulo2](https://github.com/richardqa/curso-eduroam/blob/master/modulos/actividad2.md)

7. Para la configuración del servidor Radius Local, ir al [modulo3](https://github.com/richardqa/curso-eduroam/blob/master/modulos/actividad3.md)

8. Para la configuración de los servidores LDAP y Rsyslog Centralizado, ir al [modulo4](https://github.com/richardqa/curso-eduroam/blob/master/modulos/actividad4.md)

9. Para la configuración de Radsecproxy, ir al [modulo4](https://github.com/richardqa/curso-eduroam/blob/master/modulos/actividad4.md)

10. Para la configuración del sistema de monitoramiento F-Ticks, ir al [modulo5](https://github.com/richardqa/curso-eduroam/blob/master/modulos/actividad4.md)



