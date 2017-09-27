## EVALUACION 2

Esta segunda evaluación consistirá en visualizar los Logs del servidor Radius una vez ellos autoricen o nieguen el acceso de un usuario al servidor Radius Local.

El proceso para iniciar Radius con Syslog es bastante sencillo. Los pasos a seguir son:

- Modificar el archivo /etc/syslog.conf
- Reinciar el demonio syslog
- Modificar el archivo radiusd.conf
- Reiniciar el Radius:  radiusd -fxx -l stdout 

Las 8 diferentes prioridades para Syslogs: debug, info, notice, warning, err, crit, alert, emerg.

    debug
    info: Fticks
    notice: authentication messages
    warning
    err: radius errors
    crit
    alert
    emerg

1. Ejecute “radtest” con su propio usuario en su servidor Radius Local y copie el resultado de los logs que se obtiene.

```
radtest -t pap bob@example.edu.uy hello 127.0.0.1 0 eduroam
```

En el archivo radius-notice.log se observará el evento enviado por radtest contra el Localhost

```
tail -f /home/<usuario>/radius-notice.log
Fri Sep 26 19:06:30 2011: Auth: Login OK: [bob/hello] (from client localhost port 111)
Usuario Aceptado user
```

2. Envíe este resultado a los instructores por correo electrónico.
