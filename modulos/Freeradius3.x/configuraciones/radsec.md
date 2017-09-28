#### Configuración para el servidor Radius Seguro (RADSEC)

El archivo radsec permite la creación del modulo de seguridad para el protocolo Radius. Este módulo de seguridad consiste en que el canal de comunicación entre un servidor Radius Local y su servidor Federado se establezca a traves de un Tunel TCP/SSL, reemplazando a la comunicación por default del Radius (UDP).

Para la configuración del módulo Radsec, es necesario seguir los siguientes pasos:


1. Crear el archivo radsec: touch /usr/local/etc/raddb/sites-available/radsec

2. Copiar éste contenido [radsec](https://www.github.com/richardqa/curso-eduroam/blob/master/modulos/radsec) y pegarlo en el archivo creado *radsec*.

3. Reemplazar la información mostrada en el archivo *radsec* y cambiar las informaciones siguientes: 

```
Cambiar *example* por el nombre de tu institución. Por ejemplo, radius*seciu*.edu.uy.crt

Cambiar <clave-privada-radius> por la clave secreta (passphase) colocada al momento de generar las claves privada/publica

Cambiar <clave-GPG> por la clave GPG creada en el modulo 2.
```

4. Es necesario crear un enlace simbólico del archivo radsec al directorio activo /usr/local/etc/raddb/sites-enabled/

```
cd /usr/local/etc/raddb/sites-enabled

ln -s ../sites-available/radsec .
```

Finalmente, se muestra el contenido del archivo **radsec** a ser corregido:

```
listen {
    ipaddr = *
    port = 2083
    type = auth
    proto = tcp
    virtual_server = default
    clients = radsec
    limit {
        max_connections = 0
        lifetime = 0
        idle_timeout = 3600
    }
    tls {
        certdir = ${confdir}/certs/radsec
        cadir = ${confdir}/certs/radsec
        private_key_password = <clave-privada-radius>
        private_key_file = /usr/local/etc/raddb/certs/radsec/private/radius.key
        certificate_file = /usr/local/etc/raddb/certs/radsec/radius.example.edu.uy.crt
        ca_file = /usr/local/etc/raddb/certs/radsec/ca.crt
        dh_file = /usr/local/etc/raddb/certs/radsec/dh
        random_file = /usr/local/etc/raddb/certs/radsec/random
        fragment_size = 8192
        include_length = yes
        cipher_list = "DEFAULT"
        cache {
              enable = yes
              lifetime = 24 # hours
              max_entries = 255
        }
        require_client_cert = yes
        verify {
        }
    }
}
listen {
    ipv6addr = ::
    port = 2083
    type = auth
    proto = tcp
    clients = radsec
    tls {
        certdir = ${confdir}/certs/radsec
        cadir = ${confdir}/certs/radsec
        private_key_password = <clave-privada-radius>
        private_key_file = /usr/local/etc/raddb/certs/radsec/private/radius.key
        certificate_file = /usr/local/etc/raddb/certs/radsec/radius.example.edu.uy.crt
        ca_file = /usr/local/etc/raddb/certs/radsec/ca.crt
        dh_file = /usr/local/etc/raddb/certs/radsec/dh
        random_file = /usr/local/etc/raddb/certs/radsec/random
        fragment_size = 8192
        include_length = yes
        cipher_list = "DEFAULT"
        cache {
              enable = yes
              max_entries = 255
        }
        require_client_cert = yes
        verify {
        }
    }
}
clients radsec {
    limit {
        max_connections = 0
        lifetime = 0
        idle_timeout = 3600
    }
    client 127.0.0.1 {
        ipaddr = 127.0.0.1
        proto = tls
        secret = <clave-GPG>
    }
    client uy {
        ipaddr = 164.73.128.76
        proto = tls
        secret = <clave-GPG>
        limit {
                max_connections = 0
                lifetime = 0
                idle_timeout = 3600
        }
    }
}
listen {
       ipaddr = 127.0.0.1
       port = 4000
       type = auth
}
home_server uy1 {
    ipaddr = 164.73.128.76
    port = 2083
    type = auth
    secret = <clave-GPG>
    proto = tcp
    status_check = none
    tls {
        certdir = ${confdir}/certs/radsec
        cadir = ${confdir}/certs/radsec
        private_key_password = <clave-privada-radius>
        private_key_file = /usr/local/etc/raddb/certs/radsec/private/radius.key
        certificate_file = /usr/local/etc/raddb/certs/radsec/radius.example.edu.uy.crt
        ca_file = /usr/local/etc/raddb/certs/radsec/ca.crt
        dh_file = /usr/local/etc/raddb/certs/radsec/dh
        random_file = /usr/local/etc/raddb/certs/radsec/random
        fragment_size = 1500
        include_length = yes
        cipher_list = "DEFAULT"
    }
}
home_server_pool UY {
         type = fail-over
         home_server = uy1
}
realm "~.+$" {
       auth_pool = UY
       nostrip
}
 ```
Nota 1: Recuerde que cada cambio que realiza **Reiniciar su servidor Radius**. Se sugiere que se reinicie desde el modo **debug**

```
radiusd -fxx -l stdout
```

Nota 2: Si en caso el puerto del servidor Radius esta en **uso**, entonces matamos el proceso del Radius y lo reiniciamos nuevamos.
```
ps aux |grep radiusd
kill -9 <proceso_radius_encontrado>
```
