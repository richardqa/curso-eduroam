### Configuraci胣 de F-ticks para eduroam
 ```
1. Configuraci贸n del m贸dulo linelog en el Radius Local

En este paso se agrega un nuevo bloque **fticks** al inicio del archivo /usr/local/etc/raddb/mods-available/linelog. Este bloque responde ante un evento de autenticaci贸n exitosa cn *Access-Acept* y OK, y ante un evento de autenticaci贸n fallida con *Access-Reject* y FAIL.

linelog f_ticks {
       filename = syslog
       format = ""
       reference = "f_ticks.%{%{reply:Packet-Type}:-format}"
       f_ticks {
          Access-Accept = "F-TICKS/eduroam-la/1.0#REALM=%{Realm}#User-eduroam=%{User-Name}#VISINST=%{Client-Shortname}#VISCOUNTRY=PE#CSI=%{Calling-Station-Id}#RESULT=OK#"
          Access-Reject = "F-TICKS/eduroam-la/1.0#REALM=%{Realm}#User-eduroam=%{User-Name}#VISINST=%{Client-Shortname}#VISCOUNTRY=PE#CSI=%{Calling-Station-Id}#RESULT=FAIL#"
       }
}
...

2. Activar el modulo f-ticks en tu Radius Local

En el archivo de configuraci贸n /etc/freeradius/sites-enabled/default y en /etc/freeradius/sites-enabled/inner-tunnel agregar las siguientes l铆neas seg煤n muestra el cuadra de abajo.


post-auth {

	 ...
        f_ticks


        Post-Auth-Type REJECT {
         f_ticks
          attr_filter.access_reject
        }

3. Reiniciar el servicio *radius* y hacer la prueba de autenticaci贸n local y remota cn o*radtest*,  y desde otra consola verificar los logs que se obtiene al hacer lo siguiente:

tail  -f  /root/radius-fticks.log

