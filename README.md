# Nuevo curso de *eduroam* para instituciones académicas de Latino América

## Introducción

Este curso esta dirigido a los responsables de servicio de red inalámbrica de las instituciones académicas de las NRENs y a los que quieran introducir mejoras en sus servicios usando las nuevas versiones del Protocolo Radius. El objetivo del curso es brindar capacitación a los asistentes en la instalación, configuración y mantenimiento de los servidores RADIUS. En esta oportunidad, el curso de capacitación se ha actualizado agregando el módulo de Radsec.

<a href="http://www.youtube.com/watch?feature=player_embedded&v=qk9aljqu20A
" target="_blank"><p align="center"><img src="https://github.com/richardqa/curso-eduroam/blob/master/imagenes/eduroam1.png" alt="IMAGE ALT TEXT HERE" width="480" height="360" border="10" /></p></a>

## Modulo 1: Configuración del Radius Local y Certificados Digitales (Miercoles 27 Setiembre)

- Introducción: Visión general de eduroam (09:00-09:40h)
- Protocolo RADIUS: Aspectos Generales (09:40-10:20h)
- Certificados digitales X509 y GPG (10:20-10:50)
- Práctica 1: Crear una autoridad certificadora (CA) privada y certificados digitales para el Radius (10:50-11:20)

**Break: 11:20 a 11:40hrs**

- Práctica 2: Generar claves GPG para el intercambio de claves entre servidores Radius (11:40-12:00h)
- Protocolos de Autenticación y Clientes Radius (12:00-12:30h)
- Evaluación 1: Pruebas de autenticación PAP y MsCHAPv2 usando Radtest y Eapol_Test (12:30-13:00h)

**Almuerzo: 13:00 a 14:00hrs**

- Base de Datos SysLog: Aspectos generales (14:00-14:20)
- Práctica 3: Configuración básica de un servidor Rsyslog (14:20-14:40h)
- Servicios LDAP: Aspectos generales (14:40-15:00h)
- Practica 4: Configurar archivo de cliente y usuarios en LDAP (15:00-15:20h)
- Práctica 5: Configurar PHPLdapAdmin para administrar usuarios LDAP (15:20-15:40h)
- Evaluación 2: Validación Local Radius usando usuarios Ldap (15:40-16:00h)

**Break: 16:00-16:20hrs**

- Fail-over y Balanceamiento de carga en el Radius Local (16:20-17:00h)
- Proceso de integración del servidor Radius con otras bases de Datos (Google, Microsoft, Zimbra, etc) (17:00-18:00h)

## Modulo 2: Redes Inalámbricas y Pruebas de Autenticación TTLS (Jueves 28 Setiembre)

- Introducción a 802.11 y 802.1x (09:00-09:40h)
- Seguridad en Redes WiFi (WEP, WPA y WPA2) (09:40-10:00h)
- Métodos de autenticación EAP (10:00-10:30)
- Configuración 802.1x y Radius en Access Points (10:30-11:00h)
- Configuración de métodos de autenticación EAP-TTLS y EAP-PEAP en el Radius (11:00-11:20h)

**Break: 11:20 a 11:40hrs**

- Configuración del software del suplicante en Linux, Windows y MAC (11:40-12:20h)
- Evaluación 3: Pruebas de autenticación Local EAP-TTLS desde los suplicantes en Linux, Windows y MAC (12:20-13:00h)
Almuerzo: 13:00 a 14:00hrs
- Radsec: Aspectos Generales (14:00-14:40h)
- Configuración del servicio RadSec para el Radius Local (14:40-15:10h)
- Evaluación 4: Pruebas de autenticación Local y remota usando EAP-TTLS y Radsec (Android, Iphone, MacOSx, Linux, Windows) (15:10-16:00h)

**Break: 16:00-16:20hrs**

- Monitoreo del Radius usando F-ticks (16:20-16:40h)
- Configuración del módulo y servicios F-ticks para el servidor Radius Local (16:40-17:00h)
- Evaluación 5: Pruebas de Monitoreo del servicio Radius Local usando F-ticks (17:00-18:00h)

## Modulo 3: Políticas de eduroam y su Futuro (Viernes 29 Setiembre)

- Políticas Locales y globales de eduroam (09:00-09:40h)
- Adherencia del servidor Radius Local a eduroam (CAT eduroam) (09:40-10:40h)
- Nuevos servicios de eduroam (radsec y radiator) (10:40-11:20h)

**Break: 11:20 a 11:40hrs**

- Reportes de Incidentes en eduroam (11:40-12:00)
- Visión al Futuro de eduroam (12:00-12:30)
- Preguntas abiertas para el debate (12:30-13:00h)
- Clausura del Curso de eduroam (13:00-13:10h)

## Pasos previos para la configuración del servidor Radius

Pre-requisitos:

1. Éste curso esta desarrollado para ser implementado en Ubuntu 16.04 LTS.

2. Cada usuario podrá conectarse remotamente a su servidor Local de su institución y seguir el procedimiento del curso. También se dispone de una imagen .OVA y de imágenes pre-configuradas en Docker. Para descargar la imágen ir AQUI, y para importar las imágenes en Docker ir a los siguientes enlaces:

 ```
docker pull richardqa/radius3-vmlocal
docker pull richardqa/radius3-vmlocal2
docker pull richardqa/radius3-federado

 ```
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
4. Para la configuración del servidor Radius Local usando Freeradius 2.x, ir al [modulo3-1](https://github.com/richardqa/curso-eduroam/blob/master/modulos/Freeradius2.x/README.md)
5. Para la configuración del servidor Radius Local usando Freeradius 3.x, ir al [modulo3-2](https://github.com/richardqa/curso-eduroam/blob/master/modulos/Freeradius3.x/README.md)
5. Para la configuración de los servidores LDAP y Rsyslog Centralizado, ir al [modulo4](https://github.com/richardqa/curso-eduroam/blob/master/modulos/Configura-LDAP-LOG.md)
6. Para la configuración del sistema de monitoramiento F-Ticks, ir al [modulo5](https://github.com/richardqa/curso-eduroam/blob/master/modulos/F-ticks.md)
~                                                                                                                                                             
