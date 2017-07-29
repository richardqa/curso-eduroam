#### Configuración simple de bloques para un Cliente Localhost, y un Cliente para la Federación
 ```
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

client federacao {
        ipaddr          = <IP-Federado-NREN>
        secret          = eduroam
        shortname       = federacao
}
 ```