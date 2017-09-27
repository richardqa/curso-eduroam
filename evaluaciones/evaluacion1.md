## EVALUACION 1
 
La primera evaluación consistirá en realizar consultas simples usando el programa **radtest**. Estas consultas son realizadas sobre su mismo Radius Local. Por ejemplo:

```
Usage: radtest [OPTIONS] user passwd radius-server[:port] nas-port-number secret [ppphint] [nasname]
        -d RADIUS_DIR       Set radius directory
        -t <type>           Set authentication method
                            type can be pap, chap, mschap, or eap-md5
        -P protocol         Select udp (default) or tcp
        -x                  Enable debug output
        -4                  Use IPv4 for the NAS address (default)
        -6                  Use IPv6 for the NAS address

```
En nuestro ejercicio vamos a usar **pap** y **mschap**. 

```
radtest -t pap bob@example.edu.uy hello 127.0.0.1 0 eduroam
radtest -t mschap bob@example.edu.uy hello 127.0.0.1 0 eduroam

```

Apareció un mensaje **Accept-Accept**. Si es SI, entonces ha pasado el ejercicio. Si es NO, revise sus configuraciones y vuelve a intentarlo.
