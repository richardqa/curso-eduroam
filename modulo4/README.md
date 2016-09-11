# Configuración de LOGS y LDAP

## Configurar un cliente logs para el servidor RADIUS Local

Editar el archivo /etc/freeradius/radiusd.conf

```
# Bloque logs
...
log {
destination = syslog
file = ${logdir}/radius.log
# requests = ${logdir}/radiusd-%{% {Virtual-Server}:-DEFA ULT}-%Y%m%d.log
syslog_facility = local1
stripped_names = yes
auth = yes
auth_badpass = yes
auth_goodpass = yes
msg_goodpass = "Usuario Aceptado %{User-Name}"
msg_badpass = "Usuario Rechazado"
}
...
```
NOTA:
```
destination = syslog: Usaremos como destino el demonio “syslog” para los logs de
autenticaciones
syslog_facility = local1: Tomaremos como referencia la facility “local1” según
http://wiki.freeradius.org/Syslog-HOW TO
```
Editar el archivo /etc/rsyslog.conf

```
...
module(load="imudp")
input(type="imudp" port="514")
local1.=notice  /root/radius-notice.log
...
```
Reiniciar el demonio Rsyslog: service rsyslog restart

Pruebas de Rsyslog:

Ejecute un test de autenticación a su Localhost usando la herramienta "Radtest"

En el archivo radius-notice.log se observará el evento con radtest enviado al Localhost

```
tail -f /root/radius-notice.log
Fri Sep 30 19:06:30 2011: Auth: Login OK: [user1/pass1] (from client localhost port 111)
Usuario Aceptado user
```
Evaluación 2:

Registro de Logs en el servidor RADIUS

1. Ejecute “radt est” con su propio usuario en su servidor Radius Local y copie el resultado de
los logs que se obtiene.
2. Envíe este resultado a los instructores por correo electrónico.

## Instalación y configuración de un servidor LDAP de pruebas

NOTA: Si la institución participante ya dispone de una infraestructura de LDAP, podrían usar
dicho servidor sin necesidad de realizar éste paso.

- Instalación de un servidor LDAP

Instalar los siguientes paquetes:
```
apt-get installlapache2 slapd ldap-utils phpldapadmin libapache2mod-php5    
```
Como al instalar el servidor LDAP se generan parámetros por defecto, nos conviene
reinstalarlo para su configuración manual.

Ejecutar: dpkg-reconfigure slapd

```
Configuring slapd
-----------------
If you enable this option, no initial configuration or database will be created for you.

*Omit OpenLDAP server configuration? [yes/no]* no

The DNS domain name is used to construct the base DN of the LDAP directory. For example, 'foo.example.org' will create the directory with
'dc=foo, dc=example, dc=org' as base DN.

*DNS domain name*: institucion.example.com

Please enter the name of the organization to use in the base DN of your LDAP directory.

*Organization name*: institucion

Please enter the password for the admin entry in your LDAP directory.

*Administrator password*: 

Please enter the admin password for your LDAP directory again to verify that you have typed it correctly.

*Confirm password*: 

HDB and BDB use similar storage formats, but HDB adds support for subtree renames. Both support the same configuration options.

The MDB backend is recommended. MDB uses a new storage format and requires less configuration than BDB or HDB.

In any case, you should review the resulting database configuration for your needs. See /usr/share/doc/slapd/README.Debian.gz for more
details.

  1. BDB  2. HDB  3. MDB
Database backend to use: 2

*Do you want the database to be removed when slapd is purged? [yes/no] no*

There are still files in /var/lib/ldap which will probably break the configuration process. If you enable this option, the maintainer scripts
will move the old database files out of the way before creating a new database.

*Move old database? [yes/no] si*

*Move old database? [yes/no] yes*

The obsolete LDAPv2 protocol is disabled by default in slapd. Programs and users should upgrade to LDAPv3.  If you have old programs which
can't use LDAPv3, you should select this option and 'allow bind_v2' will be added to your slapd.conf file.

*Allow LDAPv2 protocol? [yes/no] no*
```
Para visualizar el arbol LDAP que tenemos configurado hasta el momento:
```
slapcat 
dn: dc=institucion,dc=example,dc=com
objectClass: top
objectClass: dcObject
objectClass: organization
o: institucion
dc: institucion
structuralObjectClass: organization
entryUUID: f08a74ac-0c12-1036-846b-49b58d711882
creatorsName: cn=admin,dc=institucion,dc=example,dc=com
createTimestamp: 20160911022650Z
entryCSN: 20160911022650.192559Z#000000#000#000000
modifiersName: cn=admin,dc=institucion,dc=example,dc=com
modifyTimestamp: 20160911022650Z

dn: cn=admin,dc=institucion,dc=example,dc=com
objectClass: simpleSecurityObject
objectClass: organizationalRole
cn: admin
description: LDAP administrator
userPassword:: e1NTSEF9NW40QzRycE9yYlpscStHV2xXdFZ1RUp3SjkzeWdXdUM=
structuralObjectClass: organizationalRole
entryUUID: f09c2256-0c12-1036-846c-49b58d711882
creatorsName: cn=admin,dc=institucion,dc=example,dc=com
createTimestamp: 20160911022650Z
entryCSN: 20160911022650.308423Z#000000#000#000000
modifiersName: cn=admin,dc=institucion,dc=example,dc=com
modifyTimestamp: 20160911022650Z
```
Configuración de usuarios y grupos LDAP

- Configuración de un grupo `usuarios` dentro del arbol Ldap. Para esto crearemos un archivo con extensión ".ldif" en donde adicionaremos las siguientes lineas:
```
dn: ou=usuarios,dc=institucion,dc=example,dc=com
objectClass: top
objectClass: organizationalUnit
ou: usuarios
```
- Configuración de un usuario dentro del arbol Ldap. Para esto, crearemos otro archivo con extensión ".ldif" en donde adicionaremos las siguientes lineas:
```
dn: cn=test test,ou=usuarios,dc=institucion,dc=example,dc=com
givenName: test
sn: test
cn: test test
uid: test
mail: test@institucion.example.com
userPassword: {MD5}Rmmn2aOSKJIqZR7UQdxqQQ==
objectClass: inetOrgPerson
objectClass: top
```
Observa en el bloque de arriba que el atributo *userPassword* fue obtenido realizando un hash en MD5 al password del usuario de pruebas test@institucion.example.com

```
slappasswd -h {md5}
New password: <clave-cualquiera>
Re-enter new password: <repita-clave>
```
ldapadd -x -W -D "cn=admin,dc=institucion,dc=example,dc=com" -f eduroam.ldif 
adding new entry "ou=usuarios,dc=institucion,dc=example,dc=com"

ldapadd -x -W -D "cn=admin,dc=institucion,dc=example,dc=com" -f users.ldif 
adding new entry "cn=test test,ou=usuarios,dc=institucion,dc=example,dc=com"

service slapd restart
 * Stopping OpenLDAP slapd                                                                                                              [ OK ] 
 * Starting OpenLDAP slapd                                                                                                              [ OK ] 
```
- Configuración del cliente LDAP para el servidor Radius local

Ahora editaremos el módulo ldap del servidor Radius <Institución> para que éste pueda
conectarse con el servidor LDAP y así poder “logearse” con los usuarios creados del mismo.
El archivo para configuración el modulo “ldap”, se encuentra en la ruta:
/etc/freeradius/modules/ldap

```
ldap {
...
server = 127.0.0.1
port = 389
basedn = "ou=usuarios,dc=institucion,dc=example,dc=com"
filter = "(uid=%{%{Stripped-User-Name}:-% {User-Name}})"
base_filter = "(objectclass=radiusprofile)"
...
}
```
Editamos el servidor virtual default del Radius (archivos ../sites-enables/default y ../sites-
enabled/inner-tunnel)

El archivo de configuración es: /etc/freeradius/sites-enabled/default, y /etc/freeradius/sites-
enabled/inner-tunnel
```
authorize {
...
ldap
...
}
authenticate {
...
Auth-Type LDAP {
ldap
}
... }
```
## Evaluacion 3: Validación de sus usuarios LDAP hacia su servidor Radius.



