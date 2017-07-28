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
        private_key_password = eduroam
        private_key_file = ${certdir}/private/<PrivKey-cert>.key
        certificate_file = ${certdir}/radius.<Domain>.crt
        ca_file = ${cadir}/ca.crt
        dh_file = ${certdir}/dh
        random_file = ${certdir}/random
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
        private_key_password = eduroam
        private_key_file = ${certdir}/private/<PrivKey-cert>.key
        certificate_file = ${certdir}/radius.<Domain>.crt
        ca_file = ${cadir}/ca.crt
        dh_file = ${certdir}/dh
        random_file = ${certdir}/random
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
    client mx {
        ipaddr = 172.17.0.4
        proto = tls
        secret = eduroam
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
home_server nren1 {
    ipaddr = <Federation-IP>
    port = 2083
    type = auth
    secret = eduroam
    proto = tcp
    status_check = none
    tls {
        certdir = ${confdir}/certs/radsec
        cadir = ${confdir}/certs/radsec
        private_key_password = eduroam
        private_key_file = ${certdir}/private/<PrivKey-cert>.key
        certificate_file = ${certdir}/radius.<Domain>.crt
        ca_file = ${cadir}/ca.crt
        dh_file = ${certdir}/dh
        random_file = ${certdir}/random
        fragment_size = 1024
        include_length = yes
        cipher_list = "DEFAULT"
    }
}
home_server_pool NREN {
         type = fail-over
         home_server = nren1
}
realm "~.+$" {
       auth_pool = NREN
       nostrip
}
