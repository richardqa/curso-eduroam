# Nuevo Curso de **eduroam** para las Instituciones Académicas de la Red Académica de Uruguay (RAU)

## Objetivo del curso

Este curso esta dirigido a los responsables del servicio de red inalámbrica de las instituciones académicas y a los que quieran introducir mejoras en sus servicios usando las nuevas versiones del Protocolo Radius. El objetivo del curso es brindar capacitación a los asistentes en la instalación, configuración y mantenimiento de los servidores RADIUS. En esta oportunidad, el material se ha actualizado agregando el módulo de seguridad Radsec

## Modulo 1: Radius Local y Certificados Digitales (Miercoles 27 Setiembre)

- Introducción: Visión general de eduroam (09:00-09:40h)
- Protocolo RADIUS: Aspectos Generales (09:40-10:20h)
- Certificados digitales X509 y GPG (10:20-10:50)
- Práctica 1: Generar una solicitud de certificado de consulta usando X509. Ver [modulo1](https://github.com/richardqa/curso-eduroam/blob/master/modulos/Configura-Certs.md) (10:50-11:20)

**Break: 11:20 a 11:40hrs**

- Práctica 2: Generar claves GPG para el intercambio de claves entre servidores Radius. Ver [modulo2](https://github.com/richardqa/curso-eduroam/blob/master/modulos/Configura-GPG.md).
- Protocolo de autenticación interna y configuración del clientes Radius. Ver [Clientes](https://github.com/richardqa/curso-eduroam/blob/master/modulos/Freeradius3.x/configuraciones/clients.md), [Proxy](https://github.com/richardqa/curso-eduroam/blob/master/modulos/Freeradius3.x/configuraciones/proxy.md) y [Usuarios](https://github.com/richardqa/curso-eduroam/blob/master/modulos/Freeradius3.x/configuraciones/users.md).
- **Evaluación 1**: Pruebas de autenticación PAP y MsCHAP usando Radtest. Ver [Evaluación1](https://github.com/richardqa/curso-eduroam/blob/master/evaluaciones/evaluacion1.md).

**Almuerzo: 13:00 a 14:00hrs**

- Base de Datos SysLog: Aspectos generales.
- Práctica 3: Configuración básica de un servidor Rsyslog. Ver [LOG](https://github.com/richardqa/curso-eduroam/blob/master/modulos/Configura-LOG.md).
- Servicio LDAP: Aspectos generales.
- Práctica 4: Configurar archivo de cliente y grupos en LDAP. Ver [LDAP](https://github.com/richardqa/curso-eduroam/blob/master/modulos/Configura-LDAP.md).
- Práctica 5: Configurar PHPLdapAdmin para administrar usuarios LDAP.

**Break: 16:00 a 16:20hrs**

- **Evaluación 2**: Pruebas de Radius usando Syslog. Ver [Evaluación2](https://github.com/richardqa/curso-eduroam/blob/master/evaluaciones/evaluacion2.md).
- **Evaluación 3**: Validación local de usuarios LDAP. Ver [Evaluación3](https://github.com/richardqa/curso-eduroam/blob/master/evaluaciones/evaluacion3.md).

## Modulo 2: Redes Inalámbricas y Pruebas de Autenticación TTLS (Jueves 28 Setiembre)

- Introducción a 802.11 y 802.1x
- Seguridad en Redes WiFi (WEP, WPA y WPA2).
- Métodos de autenticación EAP.
- Práctica 6: Configuración 802.1x y Radius en Access Points.
- Práctica 7: Configuración de métodos de autenticación EAP-TTLS y EAP-PEAP en el Radius.

**Break: 11:20 a 11:40hrs**

- Práctica 8: Configuración del software del suplicante en Linux, Windows y MAC.
- **Evaluación 3**: Pruebas de autenticación Local EAP-TTLS desde los suplicantes en Linux, Windows y MAC.

**Almuerzo: 13:00 a 14:00hrs**

- Radsec: Aspectos Generales.
- Práctica 9: Configuración del servicio RadSec para el Radius Local.
- **Evaluación 4**: Pruebas de autenticación Local y remota usando EAP-TTLS y Radsec (Android, Iphone, MacOSx, Linux, Windows).

**Break: 16:00 a 16:20hrs**

- Monitoreo del Radius usando F-ticks.
- Práctica 10: Configuración del módulo y servicios F-ticks para el servidor Radius Local.
- **Evaluación 5**: Pruebas de Monitoreo del servicio Radius Local usando F-ticks.

## Modulo 3: Políticas y Futuro de eduroam (Viernes 29 Setiembre)

- Políticas Locales y globales de eduroam
- Prática 11: Adherencia del servidor Radius Local a eduroam (CAT eduroam).
- Nuevos servicios de eduroam (radsec y radiator).

**Break: 11:20 a 11:40hrs**

- Reportes de Incidentes en eduroam.
- Visión al Futuro de eduroam.
- Fail-over y Balanceamiento de carga en el Radius Local.
- Proceso de integración del servidor Radius con otras bases de Datos (Google, Microsoft, Zimbra, etc).
- Preguntas abiertas para el debate.
- Clausura del Curso de eduroam.
