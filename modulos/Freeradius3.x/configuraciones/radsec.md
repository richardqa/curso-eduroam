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
        private_key_password = <clave-secreta>
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
        private_key_password = <clave-secreta>
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
        secret = eduroam
    }
    client uy {
        ipaddr = federado.example.edu.uy
        proto = tls
        secret = <clave-secreta>
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
    ipaddr = federado.example.edu.uy
    port = 2083
    type = auth
    secret = <clave-secreta>
    proto = tcp
    status_check = none
    tls {
        certdir = ${confdir}/certs/radsec
        cadir = ${confdir}/certs/radsec
        private_key_password = <clave-secreta>
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
