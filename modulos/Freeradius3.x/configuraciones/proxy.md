#### Configuración simple de bloques par el Proxy Radius
 ```
El archivo **proxy.conf** almacena las directivas de configuración de los realms para el Radius Local. Estas entradas cntrolan el comportamiento de las consultas de servidores Radius a otros servidores Radius remotos.

proxy server {
        default_fallback = no
}
home_server localhost {
        type = auth
        ipaddr = 127.0.0.1
        port = 1812
        secret = <clave-GPG>
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
home_server FTLR-UY {
        type = auth
        ipaddr = 164.73.128.76
        port = 1812
        secret = <clave-GPG>
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
home_server_pool my_localhost {
        type            = fail-over
        home_server     = localhost
}


home_server_pool my_auth_failover {
        type = fail-over
        home_server = federacao
}


realm DEFAULT {
        auth_pool = my_auth_failover
        nostrip
}

realm LOCAL {
}


realm NULL {
        secret          = <clave-GPG>
}

realm "~(.*\.)*example\.edu\.uy$" {
        auth_pool       = my_localhost
        secret          = <clave-GPG>
}
 ```
