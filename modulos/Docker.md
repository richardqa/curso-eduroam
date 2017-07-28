# Importando Imágenes Pre-configuradas en Docker

## Descargar las imágenes Docker usadas en el Curso
 ```
docker pull richardqa/radius3-vmlocal
docker pull richardqa/radius3-vmlocal2
docker pull richardqa/radius3-federado
 ```
## Acceder a cada imágen Docker desde una terminal diferente:

 ```
docker run -it --name=Radius1 --hostname=Radius1 richardqa3-vmlocal /bin/bash
docker run -it --name=Radius2 --hostname=Radius2 richardqa3-vmlocal2 /bin/bash
docker run -it --name=Federado --hostname=Federado richardqa3-federado /bin/bash
 ```
## Verificar las configuraciones de red de cada Docker

 ```
radius3-VMLocal: 172.17.0.2 == radius.redclara.pe
radius3-VMLocal2: 172.17.0.4 == radius.redclara2.pe
radius3-federado: 172.17.0.3 == radius.federado.pe
 ```
## Verificar /etc/hosts de cada VM, verificar que las tres VMs tengan lo seguiente:
 ```
172.17.0.2 radius.redclara.pe
172.17.0.3 federado.redclara.pe
172.17.0.4 radius.redclara2.pe
 ```
## Verificar el valor CN de las claves públicas de cada servidor Radius. Por exemplo, para el Radius1, el valor CN da clave publica radius.redclara.pe.crt es:
 ```
openssl x509 -in radius.redclara.pe.crt -noout -text |grep CN
Issuer: C=PE, ST=Lima, L=Lima, O=DIDT/emailAddress=eduroam@redclara.pe, CN=Autoridad Certificadora privada de RAAP
Subject: C=PE, ST=Lima, O=DIDT, CN=172.17.0.2/emailAddress=eduroam@redclara.pe
 ```
## Iniciar los servidores Radius de la seguiente manera:

Para el servidor Radius1: radius.redclara.pe
 ```
radiusd -fxx -l stdout
 ```
Para el servidor Radius2: radius.redclara2.pe
 ```
radiusd -fxx -l stdout
 ```
Para el servidor Federado: radius.federado.pe
 ```
radsecproxy -c /etc/radsecproxy.conf -d 5 -f
 ```
## Verificar que el servico LDAP esta activo:  "service slapd status". Si no estuviera activo, usar "service slapd start". El usuario de testing pre-configurado en LDAP es richardqa@redclara.pe (clave:inictel) para Radius1, e richardqa@redclara2.pe (clave: inictel) para Radius2

## Activar el servico SSH de cada servidor Radius. Existe un usuario creado (user: richardqa,  clave: inictel). Acceder desde la consola al servidor Radius1 usando SSH,
 ```
ssh richardqa@172.17.0.2
radtest richardqa@redclara.pe inictel 127.0.0.1 0 eduroam   (Verificar OK)
radtest richardqa@redclara2.pe inictel 127.0.0.1 0 eduroam (Verificar OK)
 ```
