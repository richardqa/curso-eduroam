# Configuración inicial del servidor Radius  

## Configuración de los clientes Radius (Local y Remoto)

Primeramente, notar que en el archivo */etc/freeradius/clients.conf* se tiene creado un bloque de cliente para el Localhost (127.0.0.1) con secreto `testing123`.

En este punto, nosotros tenemos que crear un nuevo bloque de cliente que conecte a la IP del servidor Federado correspondiente al Radius Local.

```
client <Descripcion del servidor Federado> {
	ipaddr = <Colocar-IP-Federado>
	secret = <clave-compartido-GPG>
	shortname = org-<Siglas-Institucion>
}
```
## Configuración del Realm para el servidor Radius. Dentro del archivo */etc/freeradius/proxy.conf* modificaremos las siguientes líneas:
```
proxy server {
         default_fallback = no
}
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

home_server eduroam { 
        type                    = auth+acct 
        ipaddr                  = <IP-Federado>
        port                    = 1812,1813
        secret                  = <clave-compartida-GPG> 
        response_windows        = 20 
        zombie_period           = 40 
        revive_interval         = 60 
        status_check            = status-server 
        check_interval          = 30 
        num_answers_to_alive    = 3 
} 
home_server_pool my_localhost {
        type            = fail-over
        home_server     = localhost
}
home_server_pool EDUROAM-FTLR { 
        type = fail-over 
        home_server = eduroam 
} 
realm <Dominio-de-tu-Institución> { 
        type = radius 
        authhost = LOCAL 
        accthost = LOCAL 
} 
realm LOCAL { 
nostrip 
} 
realm null { 
nostrip 
} 
realm “~.+$” { 
       auth_pool = EDUROAM-FTLR 
       acct_pool = EDUROAM-FTLR
       nostrip 
} 
```
## Configuración del archivo *usuarios* para el servidor Radius local
```
richardqa Cleartext-Password := "inictel"
```

# Primera evaluación: Autenticación remota de usuarios locales usando *radtest*. Este paso fallaría por razones que aún no conocemos

```
radtest <usuario>@<Dominio-Institución> <clave-usuario> <IP-federado> 0 <clave-compartida-GPG>
```
7. Una vez terminado los pasos anteriores, haz click en [modulo4](https://github.com/richardqa/curso-eduroam/blob/master/modulos/actividad4.md) para c
ontinuar con la actividad 4.
	
