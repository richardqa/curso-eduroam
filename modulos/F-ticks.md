### Configuración de F-ticks para eduroam

Esta sección del documento describes un **Formato de Logs** para ser usados como una herramienta para mediciones y la recopilación de estadsticas.

Éste sistema consiste de una serie de mensajes *Logs* de F-ticks, en donde cada uno representa un evento de autenticación simple. Cada mensaje *Log* es generado en la federación o en la misma IdP.

Un mensaje log F-ticks es una cadena de texto que es completado de la siguiente manera:

```
fticks = "F-TICKS/" federation-identifier "/" version attribute-list label = ( ALPHA / DIGIT / '_' / '-' / ':' / '.' / ',' / ';')
```
Siendo:

```
   federation-identifier = label
   version = label
   attribute-list = 1*("#" attribute "=" value ) "#"
   value = label
   attribute = ( ALPHA / DIGIT )
```

En donde, el identificador de identidad y la versión pueden ser usadas por las federaciones y otras comunidades para indicar el tipo de atributos usados. Ésta documentación no describe atributos obligatorios, sino en vez de eso proporciona una lista de atributos en uso en varias comunidades de hoy. Para futuras versiones del documento, podríamos querer definir un registro IANA para las deficiones del atributos F-ticks. Debido a las restricciones comunes a varios sistemas Logs, se espera que los atributos del F-ticks son mantenidos corto.

#### Atributos F-ticks

Comunmente los administradores de Logs de las instituciones no deberán asumir que cualquier atributo estará presente en sus logs. Dependiendo de las situaciones, cualesquiera de ellos podrían no ser considerados en el mensaje del F-ticks.

1. Realms

El atributo *Realm* es usado para transmitir el realm AAA del evento de autenticación. La presencia del atributo *Realm* implica que el mensaje fue generado por el proveedor de identidad basado en AAA.

2. VISCONTRY

Es el *Código Pais de la entidad que generó los mensajes logs.

3. CSI

Es el *Calling Station ID* de la institución asociada con el evento de autenticación. La presencia de éste atributo implica que el mensaje fue generado por el proveedor de identidad AAA.

4. Result

Es el resultado del evento de autenticación: OK o FAIL.

5. RP

El atributo RP es un identificador de la institución en el cual se confia. Una cadena unicamente indenfica a la organización envolvido en el evento de autenticacion.

6. AP

Identificar en el cual se confia. Una cadena única que identifica a la institución que se confia. Para un evento de autenticación, este es el IdP.
   
7. TS

Este es un atributo asociado con el evento de autenticación en segundos. Si éste atributo esta ausente, el consumidor podria escoger usar el *timestamp* proporcionado por el sistema de mensaje Log (e.g., syslog).

8. AN

Identificador del metodo de autenticacion

9. PN

Identificador unico para la organización que participa en el evento.

### Introducción al F-ticks

Si se requiere incluir *Usernames hasheados* en la salida, se deberia también suministrar un secreto *random salt* en las propiedades del Radius IdP. Sin el atributo *random salt*, el username no será incluido.

#### Información básica

```
F-TICKS/eduroam/1.0#REALM=%R#VISCOUNTRY=UY#CSI=%{Calling-Station-Id}#RESULT=OK#
```
#### Información avanzada
```
F-TICKS/eduroam/1.0#REALM=%R#VISCOUNTRY=UY#CSI=%{Calling-Station-Id}#RESULT=OK#VISINST=UDELAR#
```
<p align="center"><img src="https://github.com/richardqa/curso-eduroam/blob/master/imagenes/fticks1.png" alt="IMAGE ALT TEXT HERE" border="10" /></p>

<p align="center"><img src="https://github.com/richardqa/curso-eduroam/blob/master/imagenes/fticks2.png" alt="IMAGE ALT TEXT HERE" border="10" /></p>

Cada institución podra enviar, al operador de roaming nacional (RAU) información de estadistica *basica* acerca del numero de *Logins* del roaming nacional o internacional al equipo de operaciones de eduroam. El sistema puede hacer eso con F-ticks. Freeradius 3.x y Radsecproxy soportan F-ticks, compilando sus programas con **--enable-fticks**.

Cuando las definiciones del cliente son establecidas, las siguientes opciones activan el F-ticks y envian los mensajes del Syslog de una manera tal que preserve la privacidad. (e.g., parte de información hasheada en la conexión de la mac-address del dispositivo de usuario).

```
FTicksReporting Full
FTicksMAC VendorKeyHashed
FTicksKey arandomsalt
```
Los ticks finalizarán en el demonio del syslog local. Ellos no son automaticamente enviados al equipo de operaciones de eduroam. Este dependerá de las configuraciones del Syslog sobre como alcanzar el reenvio de los mensajes. Para Rsyslog, un reciente demnio de logs, lo siguiente funcionaria:

```
#radsecproxy
if      ($programname == 'radsecproxy') and ($msg contains 'F-TICKS') \
then    @192.0.2.204
&       ~
```
### Configuración de F-ticks en el servidor Radius Local

1. Configuración del módulo linelog en el Radius Local

En este paso se agregará un nuevo bloque *f_ticks* al inicio del archivo **/usr/local/etc/raddb/mods-available/linelog**. Este bloque responde ante un evento de autenticación exitosa *Access-Accept* con OK, y ante un evento de autenticación fallida *Access-Reject* con FAIL.

```
linelog f_ticks {
       filename = syslog
       format = ""
       reference = "f_ticks.%{%{reply:Packet-Type}:-format}"
       f_ticks {
          Access-Accept = "F-TICKS/eduroam-la/1.0#REALM=%{Realm}#User-eduroam=%{User-Name}#VISINST=%{Client-Shortname}#VISCOUNTRY=UY#CSI=%{Calling-Station-Id}#RESULT=OK#"
          Access-Reject = "F-TICKS/eduroam-la/1.0#REALM=%{Realm}#User-eduroam=%{User-Name}#VISINST=%{Client-Shortname}#VISCOUNTRY=UY#CSI=%{Calling-Station-Id}#RESULT=FAIL#"
       }
}
```

2. Activar el modulo f-ticks en tu Radius Local

En los archivos de configuración **/usr/local/etc/raddb/sites/available/default** y en **/usr/local/etc/raddb/sites-available/inner-tunnel** agregar las siguientes líneas **f_ticks** según como muestra el cuadra de abajo.

```
post-auth {

	 ...
        f_ticks

        Post-Auth-Type REJECT {
         f_ticks
          attr_filter.access_reject
        }
```
Nota 1: Recuerde que cada cambio que realiza **Reiniciar su servidor Radius**. En este paso, se sugiere que se reinicie desde el modo **NORMAL**, caso contrario no mostrará **NADA** de F-ticks en el archivo Logs.

```
radiusd
```

Nota 2: Si en caso el puerto del servidor Radius esta en **uso**, entonces matamos el proceso del Radius y lo reiniciamos nuevamos.
```
ps aux |grep radiusd
kill -9 <proceso_radius_encontrado>
```
3. Luego de hacer la prueba de autenticación local y remota con *radtest*, desde otra consola verificar los logs que se obtiene al hacer lo siguiente:

```
tail  -f  /home/<usuario>/logs/radius-fticks.log
```
