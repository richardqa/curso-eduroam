#### Configuración simple de bloques par el Proxy Radius

El archivo **proxy.conf** almacena las directivas de configuración de los realms para el Radius Local. Estas entradas controlan el comportamiento de las consultas de servidores Radius a otros servidores Radius remotos.

En el primer bloque ponemos **default_fallback = no** para no reenviar las consultas a un servidor cualquiera, sino a los que están escritos en nuestra configuración del Radius.
```
proxy server {
        default_fallback = no
}
```
Este segundo bloque define un ** Home Server ** que permite recibir las consultas de otros servidores Radius para la validación de su Realm.

```
home_server localhost {
        type = auth
        ipaddr = 127.0.0.1
        port = 1812
        secret = eduroam
        response_window = 20
        zombie_period = 40
        revive_interval = 120
        status_check = status-server
        check_interval = 30
        check_timeout = 4
        num_answers_to_alive = 3
        max_outstanding = 65536
        coa {
                irt = 2
                mrt = 16
                mrc = 5
                mrd = 30
        }
        limit {
              max_connections = 16
              max_requests = 0
              lifetime = 0
              idle_timeout = 0
        }
}
```
En este nuevo bloque definimos un nuevo **Home Server** redirigir las consultas hacia el servidor Federado de Uruguay (164.73.128.76).

```
home_server FTLR-UY {
        type = auth
        ipaddr = 164.73.128.76
        port = 1812
        secret = eduroam
        response_window = 20
        zombie_period = 40
        revive_interval = 120
        status_check = status-server
        check_interval = 30
        check_timeout = 4
        num_answers_to_alive = 3
        max_outstanding = 65536
        coa {
                irt = 2
                mrt = 16
                mrc = 5
                mrd = 30
        }
        limit {
              max_connections = 16
              max_requests = 0
              lifetime = 0
              idle_timeout = 0
        }
}
```
Luego, definimos dos ** Pools Home Server ** para cada Home Server creado. Cada pool podría enviar más de un **Home Server**.

```
home_server_pool my_localhost {
        type            = fail-over
        home_server     = localhost
}

home_server_pool my_auth_failover {
        type = fail-over
        home_server = FTLR-UY
}
```
Para las consultas que no puedan ser resolvidas por el Radius Local IdP, se les dejará que el Federado UY lo responda.

```
realm DEFAULT {
        auth_pool = my_auth_failover
        nostrip
}

realm LOCAL {
}
```
Finalmente, para responder consultas hacia el servidor Radius Local, creamos un bloque **real** que envie las consultas hacia el Pool **my_localhost**. El realm NULL es para consultas que no tienen un explicito Realm.

```
realm NULL {
        secret          = eduroam
}

realm "~(.*\.)*example\.edu\.uy$" {
        auth_pool       = my_localhost
        secret          = eduroam
}
 ```

Un ejemplo de configuración del archivo proxy.conf puede ser descargado desde [aquí](https://www.github.com/richardqa/curso-eduroam/blob/master/modulos/proxy.conf)

Nota 1: Recuerde que cada cambio que realiza **Reiniciar su servidor Radius**. Se sugiere que se reinicie desde el modo **debug**

```
radiusd -fxx -l stdout
```

Nota 2: Si en caso el puerto del servidor Radius esta en **uso**, entonces matamos el proceso del Radius y lo reiniciamos nuevamos.
```
ps aux |grep radiusd
kill -9 <proceso_radius_encontrado>

