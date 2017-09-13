# Nuevo curso de **eduroam** para instituciones académicas de Latino América

Este curso esta dirigido a los responsables de servicio de red inalámbrica de las instituciones académicas de las NRENs y a los que quieran introducir mejoras en sus servicios usando las nuevas versiones del Protocolo Radius. El objetivo del curso es brindar capacitación a los asistentes en la instalación, configuración y mantenimiento de los servidores RADIUS. En esta oportunidad, el curso de capacitación se ha actualizado agregando el módulo de Radsec.

<a href="http://www.youtube.com/watch?feature=player_embedded&v=qk9aljqu20A
" target="_blank"><p align="center"><img src="https://github.com/richardqa/curso-eduroam/blob/master/imagenes/eduroam_new_2017.png" alt="IMAGE ALT TEXT HERE" width="480" height="360" border="10" /></p></a>

## Pasos previos para la configuración del servidor Radius

###Pre-requisitos:

1. Éste curso esta desarrollado para ser implementado en Ubuntu 16.04 LTS

<!-- 2.	Cada usuario podrá conectarse remotamente a su servidor Local de su institución y seguir el procedimiento del curso. También se dispone de una imagen .OVA y de imágenes pre-configuradas en Docker. Para descargar la imágen ir AQUI, y para importar las imágenes en Docker ir a los siguientes enlaces:

 ```
docker pull richardqa/radius3-vmlocal
docker pull richardqa/radius3-vmlocal2
docker pull richardqa/radius3-federado

 ```
-->
3. El acceso a los servidores podrán ser realizados a través de la aplicación [Putty](http://www.putty.org/) para Windows o el terminal de comandos para Linux, cada usuario se deberá conectar al servidor Radius de su institución remotamente ó a través del programa *Docker*

        - Instalación y configuración de Docker en Linux [docker](https://docs.docker.com/engine/installation/). Docker actualmente tiene soporte para Linux, Windows y MAC OS.
        - Instalación de [Git](https://help.github.com/articles/set-up-git/)

4. Para los usuarios que se conecten a su servidor remotamente, seguir directamente los siguientes pasos:

 ```
git clone https://github.com/richardqa/curso-eduroam
cd curso-eduroam
 ```
## Primeros Pasos para la Instalación y Configuración de los Servidores Radius. 

En esta sección se tiene las primeras configuraciones del Servidor Radius.

1. Instalar el script en bash el cual instala los paquetes y políticas de seguridad básica del servidor Radius.

 ```
bash scripts/inicio.sh
 ```
2. Para la configuración de los certificados digitales X509, ir al [modulo1](https://github.com/richardqa/curso-eduroam/blob/master/modulos/Configura-Certs.md).
3. Para la configuración de claves públicas y privadas usando GPG, ir al [modulo2](https://github.com/richardqa/curso-eduroam/blob/master/modulos/Configura-GPG.md)
4. Para la configuración del servidor Radius Local usando Freeradius 3.x, ir al [modulo3-2](https://github.com/richardqa/curso-eduroam/blob/master/modulos/Freeradius3.x/README.md)
5. Para la configuración de los servidores LDAP y Rsyslog Centralizado, ir al [modulo4](https://github.com/richardqa/curso-eduroam/blob/master/modulos/Configura-LDAP-LOG.md)
6. Para la configuración del sistema de monitoramiento F-Ticks, ir al [modulo5](https://github.com/richardqa/curso-eduroam/blob/master/modulos/F-ticks.md)
