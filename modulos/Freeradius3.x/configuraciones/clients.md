#### Configuración simple de bloques para clientes Radius

En este bloque de configuración, cada servidor Radius inscribe a tres tipos de clientes: (1) Localhost, (2) Punto de Acceso, (3) Federación.

La clave **secret** del cliente **localhost** puede ser alguna clave que ustedes eligan. Esto solo es necesario para hacer pruebas de validación de usuarios desde su mismo Radius Local. Para objetivos del curso se puso que todas las claves del cliente *Localhost* tendrían que ser **eduroam**

```
# Clients Localhost
# -----------------
client localhost {
        ipaddr = 127.0.0.1
        proto = *
        secret = eduroam
        require_message_authenticator = no
        shortname = localhost
        nas_type         = other 
        limit {
                max_connections = 16
                lifetime = 0
                idle_timeout = 30
        }
}
client 127.0.1.1 {
    secret = eduroam
    shortname = localhost
}
client localhost_ipv6 {
        ipv6addr        = ::1
        secret          = eduroam
}
```
Con respecto al Punto de Acceso, solamente vamos a dejarlo colocado de forma de comentario. Una vez llegado a configurar un Punto de Acceso se reemplazaría el valor del **<IP>** por el IP de su Punto de Acceso.

```
# Clientes Punto de Acceso
# ------------------------

#client <nombre-AP> {
#       ipaddr = <IP>
#       netmask = 32
#       secret = <clave-AP>
#       shortname = ap-INICTEL-UNI
#       nastype = aruba
#}
```
Para el caso del cliente Federado, es necesario compartir una clave secreta GPG cifrada con la clave pública 0x1012D678. Sin embargo para el curso vamos a usar la misma clave **eduroam** para compartirla con la federación.

```
# Clientes Federados
# ------------------

client federacao {
        ipaddr          = 164.73.128.76
        secret          = eduroam
        shortname       = org-EXAMPLE
}
 ```
Un ejemplo de configuración del archivo clients.conf puede ser descargado desde [aquí](https://www.github.com/richardqa/curso-eduroam/blob/master/modulos/clients.conf)

Nota: Recuerde que cada cambio que realiza **Reiniciar su servidor Radius**. Se sugiere que se reinicie desde el modo **debug**

```
radiusd -fxx -l stdout
```

Nota: Si en caso el puerto del servidor Radius esta en *USO*, entonces matamos el proceso del Radius y lo reiniciamos nuevamos.
```
ps aux |grep radiusd
kill -9 <proceso_radius_encontrado>
```

