## Instalación y configuración de un servidor LDAP de pruebas

**NOTA**: Si la institución participante ya dispone de una infraestructura de LDAP, podrían usar dicho servidor sin necesidad de realizar éste paso.

- Instalación de un servidor LDAP en el mismo servidor del Radius Local

Instalar los siguientes paquetes:
```
apt-get installlapache2 slapd ldap-utils phpldapadmin libapache2mod-php5    
```
Como al instalar el servidor LDAP se generan parámetros por defecto, nos conviene reinstalarlo para su configuración manual.

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
dn: dc=example,dc=example,dc=edu,dc=uy
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

dn: cn=admin,dc=example,dc=example,dc=edu,dc=uy
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
dn: ou=usuarios,dc=example,dc=edu,dc=uy
objectClass: top
objectClass: organizationalUnit
ou: usuarios
```
- Configuración de un usuario dentro del arbol Ldap. Para esto, crearemos otro archivo con extensión ".ldif" en donde adicionaremos las siguientes lineas:
```
dn: cn=test test,ou=usuarios,dc=example,dc=example,dc=edu,dc=uy
givenName: test
sn: test
cn: test test
uid: test
mail: test@example.edu.uy
userPassword: {SSHA}huEJT32gT+NFDHd4cucpnCBXtTh/ymYN
objectClass: inetOrgPerson
objectClass: top
```
Observa en el bloque de arriba que el atributo *userPassword* fue obtenido realizando un hash de **SSHA** al password del usuario de pruebas test@example.edu.uy

```
slappasswd -h {SSHA}
New password: <clave-cualquiera>
Re-enter new password: <repita-clave>

ldapadd -x -W -D "cn=admin,dc=example,dc=edu,dc=uy" -f eduroam.ldif 
adding new entry "ou=usuarios,dc=example,dc=edu,dc=uy"

ldapadd -x -W -D "cn=admin,dc=example,dc=edu,dc=cuy" -f users.ldif 
adding new entry "cn=test test,ou=usuarios,dc=example,dc=edu,dc=uy"

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
basedn = "ou=usuarios,dc=example,dc=example,dc=edu,dc=uy"
filter = "(uid=%{%{Stripped-User-Name}:-% {User-Name}})"
base_filter = "(objectclass=radiusprofile)"
...
}
```
Editamos el servidor virtual default del Radius (archivos ../sites-enables/default y ../sites-
enabled/inner-tunnel)

El archivo de configuración es: /usr/local/etc/raddb/sites-available/default, y /usr/local/etc/raddb/sites-available/inner-tunnel
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



