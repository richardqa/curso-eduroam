# Configuración del Radius Local

Según como se observa en la figura, los servidores Radius **Locales** tendrán como dominio **example.edu.uy**, el hostname de cada radius Local será: **radius.example.edu.uy** y el usuario de pruebas **testrau@example.edu.uy** con clave **rau2017**. Cada servidor Radius se conectará con el servicio Federado de Uruguay (IP: 164.73.128.76), a través de un canal de comunicación SSL usando el protocolo **Radsec**. 

<p align="center"><img src="https://github.com/richardqa/curso-eduroam/blob/master/imagenes/eduroam2.png" alt="IMAGE ALT TEXT HERE" border="10" /></p>

También se observa en la figura que, cada servicio federado se conecta a tres servicios Radius Confederados, el cual dos de ellos son servicios Backups (líneas punteadas). Por otro lado, en el lado derecho de la figura se observa el servicio Federado de Perú (FTLR-Pe) y el Radius Local con dominio **inictel-uni.edu.pe**. Ambos de éstos servidores están actualmente conectados al servicio eduroam mundial.

El objetivo del curso es configurar los servidores Radius Locales de Uruguay al servicio federado (FTLR-Uy), para que los usuarios de esas instituciones tengan acceso al servicio de itinerancia que ofrece eduroam. La conexión entre la federación de Uruguay y los tres servicios de la confederación ya se encuentran actualmente en funcionamiento.

Para acceder a la configuración del Servidor Radius Local, haz click en [Configura_Radius](https://github.com/richardqa/curso-eduroam/blob/master/modulos/Freeradius3.x/configuraciones/README.md)
