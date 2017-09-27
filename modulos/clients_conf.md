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
# Clientes Punto de Acceso
# ------------------------

#client <nombre-AP> {
#       ipaddr = <IP>
#       netmask = 32
#       secret = <clave-AP>
#       shortname = ap-INICTEL-UNI
#       nastype = aruba
#}

# Clientes Federados
# ------------------

client federacao {
        ipaddr          = 164.73.128.76
        secret          = eduroam
        shortname       = org-EXAMPLE
}
