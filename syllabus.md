# Nuevo Curso de **eduroam** para las Instituciones Académicas de la Red Académica de Uruguay (RAU)

## Objetivo del curso

Este curso esta dirigido a los responsables del servicio de red inalámbrica de las instituciones académicas y a los que quieran introducir mejoras en sus servicios usando las nuevas versiones del Protocolo Radius. El objetivo del curso es brindar capacitación a los asistentes en la instalación, configuración y mantenimiento de los servidores RADIUS. En esta oportunidad, el material se ha actualizado agregando el módulo de seguridad Radsec

## Modulo 1: Radius Local y Certificados Digitales (Miercoles 27 Setiembre)

- Introducción: Visión general de eduroam (09:00-09:40h)
- Protocolo RADIUS: Aspectos Generales (09:40-10:20h)
- Certificados digitales X509 y GPG (10:20-10:50)
- Práctica 1: Generar una solicitud de certificado de consulta usando X509. Ver [modulo1](https://github.com/richardqa/curso-eduroam/blob/master/modulos/Configura-Certs.md) (10:50-11:20)

**Break: 11:20 a 11:40hrs**

- Práctica 2: Generar claves GPG para el intercambio de claves entre servidores Radius. Ver [modulo2](https://github.com/richardqa/curso-eduroam/blob/master/modulos/Configura-GPG.md) (11:40-12:00h)
- Protocolo de autenticación interna y configuración del clientes Radius. Ver [configuraciones](https://github.com/richardqa/curso-eduroam/blob/master/modulos/Freeradius3.x/configuraciones/clients.md). (12:00-12:30h).
- **Evaluación 1**: Pruebas de autenticación PAP y MsCHAPv2 usando Radtest y Eapol_Test (12:30-13:00h)

**Almuerzo: 13:00 a 14:00hrs**

- Base de Datos SysLog: Aspectos generales (14:00-14:20)
- Práctica 3: Configuración básica de un servidor Rsyslog (14:20-14:40h)
- Servicio LDAP: Aspectos generales (14:40-15:00h)
- Práctica 4: Configurar archivo de cliente y usuarios en LDAP (15:00-15:20h)
- Práctica 5: Configurar PHPLdapAdmin para administrar usuarios LDAP (15:20-15:40h)
- **Evaluación 2**:Validación Local Radius usando usuarios Ldap (15:40-16:00h)

**Break: 16:00 a 16:20hrs**

- Fail-over y Balanceamiento de carga en el Radius Local (16:20-17:00h)
- Proceso de integración del servidor Radius con otras bases de Datos (Google, Microsoft, Zimbra, etc) (17:00-18:00h)

## Modulo 2: Redes Inalámbricas y Pruebas de Autenticación TTLS (Jueves 28 Setiembre)

- Introducción a 802.11 y 802.1x (09:00-09:40h)
- Seguridad en Redes WiFi (WEP, WPA y WPA2) (09:40-10:00h)
- Métodos de autenticación EAP (10:00-10:30)
- Práctica 6: Configuración 802.1x y Radius en Access Points (10:30-11:00h)
- Práctica 7: Configuración de métodos de autenticación EAP-TTLS y EAP-PEAP en el Radius (11:00-11:20h)

**Break: 11:20 a 11:40hrs**

- Práctica 8: Configuración del software del suplicante en Linux, Windows y MAC (11:40-12:20h)
- **Evaluación 3**: Pruebas de autenticación Local EAP-TTLS desde los suplicantes en Linux, Windows y MAC (12:20-13:00h)

**Almuerzo: 13:00 a 14:00hrs**

- Radsec: Aspectos Generales (14:00-14:40h)
- Práctica 9: Configuración del servicio RadSec para el Radius Local (14:40-15:10h)
- **Evaluación 4**: Pruebas de autenticación Local y remota usando EAP-TTLS y Radsec (Android, Iphone, MacOSx, Linux, Windows) (15:10-16:00h)

**Break: 16:00 a 16:20hrs**

- Monitoreo del Radius usando F-ticks (16:20-16:40h)
- Práctica 10: Configuración del módulo y servicios F-ticks para el servidor Radius Local (16:40-17:00h)
- **Evaluación 5**: Pruebas de Monitoreo del servicio Radius Local usando F-ticks (17:00-18:00h)

## Modulo 3: Políticas y Futuro de eduroam (Viernes 29 Setiembre)

- Políticas Locales y globales de eduroam (09:00-09:40h)
- Prática 11: Adherencia del servidor Radius Local a eduroam (CAT eduroam) (09:40-10:40h)
- Nuevos servicios de eduroam (radsec y radiator) (10:40-11:20h)

**Break: 11:20 a 11:40hrs**

- Reportes de Incidentes en eduroam (11:40-12:00)
- Visión al Futuro de eduroam (12:00-12:30)
- Preguntas abiertas para el debate (12:30-13:00h)
- Clausura del Curso de eduroam (13:00-13:10h)
