#### Configuración simple de bloques para clientes Radius
 ```
En este bloque de configuración, cada servidor Radius inscribe a tres tipos de clientes: (1) Localhost, (2) Punto de Acceso, (3) Federación 

# Clients Localhost
# -----------------
client localhost {
        ipaddr = 127.0.0.1
        proto = *
        secret = <clave-GPG>
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
    secret = <clave-GPG>
    shortname = localhost
}
client localhost_ipv6 {
        ipv6addr        = ::1
        secret          = <clave-GPG>
}

# Clientes Punto de Acceso
# ------------------------

client <nombre-AP> {
       ipaddr = <IP>
       netmask = 32
       secret = <clave-AP>
       shortname = ap-INICTEL-UNI
       nastype = aruba
}

# Clientes Federados
# ------------------

client federacao {
        ipaddr          = 164.73.128.76
        secret          = <clave-GPG>
        shortname       = org-EXAMPLE
}
 ```
