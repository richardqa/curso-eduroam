
### Configuración de un Punto de Acceso Cisco Aironet 1240AG

Para la configuración de un Cisco Aironet con soporte AAA es necesario primero crear un nuevo modelo AAA definiendo el servidor de autenticación correspondiente, luego se creará un SSID para el acceso seguro de los usuarios y un segundo SSID para el acceso a otros usuarios, y finalmente se crearán los métodos de cifrados usados en la autenticación de los usuarios. En los ejemplos debajo se describen las configuraciones a seguir en un Punto de Acceso Cisco Aironet.

```
aaa new-model
aaa group server radius rad_eap
server <IP-Radius-IdP> auth-port 1812 acct-port 1813
aaa group server radius rad_acct

dot11 ssid eduroam
vlan 109
authentication open eap eap_methods
authentication network-eap eap_methods
authentication key-management wpa optional
accounting acct_methods
INVITADOS
dot11 ssid INVITADOS
vlan 104
authentication open
accounting acct_methods
mbssid guest-mode

encryption mode ciphers aes-ccm tkip wep128
encryption vlan 109 mode ciphers aes-ccm tkip wep128
encryption vlan 104 mode ciphers aes-ccm tkip wep128
broadcast-key change 600 membership-termination capability-change
broadcast-key vlan 109 change 600 membership-termination capability-change

```
<p align="center"><img src="https://github.com/richardqa/curso-eduroam/blob/master/imagenes/AP1.png" alt="IMAGE ALT TEXT HERE" border="10" /></p>

<p align="center"><img src="https://github.com/richardqa/curso-eduroam/blob/master/imagenes/AP2.jpg" alt="IMAGE ALT TEXT HERE" border="10" /></p>

<p align="center"><img src="https://github.com/richardqa/curso-eduroam/blob/master/imagenes/AP3.png" alt="IMAGE ALT TEXT HERE" border="10" /></p>


