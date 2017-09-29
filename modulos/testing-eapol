### Testeando tu conexión a eduroam

La forma más básica aprendida hasta el momento es usando un simple **radtest**, el cual puede apuntar a servidores remotos 
o al mismo servidor Local, lo cual las instituciones involucradas harian un simple *peering* entre ellas y verificarian 
la autenticidad del usuario.

La manera ms simple de hacer testing a eduroam es usando un suplicante que soporte 802.1x y que intente validarse a eduroam. 
Sin embargo este requiere de configurar al menos un Access Point wireless para hacer broadcast al SSID de eduroam y autenticar 
contra el servidor Radius.

Una alternativa más sofisticada es mediante una herramienta llamada **eapol_test** incluido en el paquete **wpa_supplicant**. 
Adicionales documentaciones sobre eapol_test, compilando ello esta disponible en el siguiente  [enlace](http://deployingradius.com/scripts/eapol_test/)

Nomenclatura para lanzar un testing con eapol_test:

```
eapol_test -c<config file> -a<IP of your RADIUS server> -p<Port> -s<SECRET>
```

Por ejemplo:  

```
eapol_test -c <test_conf.cfg> -a 127.0.0.1 -p 1812 -s eduroam
```
En donde el archivo de configuración tiene lo siguiente:

```
network={
   ssid="eduroam"
   key_mgmt=IEEE8021X
   eap=<PEAP or TTLS>
   pairwise=CCMP TKIP
   #pairwise=TKIP/AES/etc...
   group=CCMP TKIP WEP104 WEP40
   phase2="auth=MSCHAPV2"
   #phase2="auth=PAP"
   identity="<username@realm>"
   password="<PASSWORD>"
}
```
Finalmente, una prueba para probar la **Itinerancia** de sus usuarios desde *Cualquier Parte del Mundo* es usando esta simple herramienta:

https://radius.ics.muni.cz/eduroam-test/eduroam-test.cgi

<p align="center"><img src="https://github.com/richardqa/curso-eduroam/blob/master/imagenes/test_eduroam1.png" alt="IMAGE ALT TEXT HERE" border="10" /></p>

<p align="center"><img src="https://github.com/richardqa/curso-eduroam/blob/master/imagenes/test_eduroam2.png" alt="IMAGE ALT TEXT HERE" border="10" /></p>

<p align="center"><img src="https://github.com/richardqa/curso-eduroam/blob/master/imagenes/test_eduroam3.png" alt="IMAGE ALT TEXT HERE" border="10" /></p>
