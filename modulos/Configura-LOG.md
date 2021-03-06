## SYSLOG para el servidor Radius Local

### Configurar entradas para logs en el archivo de configuración principal del servidor RADIUS (radius.conf).

Editar el archivo /usr/local/etc/raddb/radius.conf

```
# Bloque logs
...
log {
destination = syslog
file = ${logdir}/radius.log
# requests = ${logdir}/radiusd-%{% {Virtual-Server}:-DEFAULT}-%Y%m%d.log
syslog_facility = local1
stripped_names = yes
auth = yes
auth_badpass = yes
auth_goodpass = yes
msg_goodpass = "Usuario Aceptado %{User-Name}"
msg_badpass = "Usuario Rechazado"
}
...
```

Nota 1: destination = syslog: Usaremos como destino el demonio “syslog” para los logs de autenticaciones.

Nota 2: syslog_facility = local1: Tomaremos como referencia la facility “local1” según https://wiki.freeradius.org/guide/Syslog-HOWTO.

Nota 3: file = ${logdir}/radius.log: Lo mantendremos para tener la opción de configuración del Log por defecto del Radius.

Nota 4: Recuerde que cada cambio que realiza **Reiniciar su servidor Radius**. Se sugiere que se reinicie desde el modo **debug**

```
radiusd -fxx -l stdout
```

Nota 5: Si en caso el puerto del servidor Radius esta en **uso**, entonces matamos el proceso del Radius y lo reiniciamos nuevamos.
```
ps aux |grep radiusd
kill -9 <proceso_radius_encontrado>
```

## Configurar el servidor Rsyslog localizado en el mismo Radius Local

Editar el archivo /etc/rsyslog.conf

```
...
module(load="imudp")
input(type="imudp" port="514")
local1.info     /home/<usuario>/logs/radsec-info.log
local1.debug    /home/<usuario>/logs/radsec-debug.log
local1.notice   /home/<usuario>/logs/radius-notice.log
local1.*        /home/<usuario>/logs/radius-todo.log
...
```
Reiniciar el demonio Rsyslog: 

```
service rsyslog restart
```

