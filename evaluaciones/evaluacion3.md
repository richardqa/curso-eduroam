## EVALUACION 2

Esta tercera evaluación consistirá de probar la autenticación de usuarios creados desde una base de datos LDAP.

1. Ejecute “radtest” con su propio usuario en su servidor Radius Local y copie el resultado de los logs que se obtiene.

```
radtest -t pap bob_ldap@example.edu.uy hello 127.0.0.1 0 eduroam
```

En el archivo radius-notice.log se observará el evento enviado por radtest contra el Localhost

```
tail -f /home/<usuario>/radius-notice.log
Fri Sep 26 19:06:30 2011: Auth: Login OK: [bob_ldap/hello] (from client localhost port 111)
Usuario Aceptado user

2. Envíe este resultado a los instructores por correo electrónico.
