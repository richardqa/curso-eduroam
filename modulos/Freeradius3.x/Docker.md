# Importando Imágenes Pre-configuradas en Docker
Las siguientes maquinas virtualizadas en Docker han sido ejecutads sobre Ubuntu 16.04 server y ya tienen instalado la versión reciente del Freeradius 3.0.15

## Descargar las imágenes Docker usadas en el Curso
 ```
docker pull richardqa/radius3-vmlocal
docker pull richardqa/radius3-vmlocal2
docker pull richardqa/radius3-federado
 ```
## Acceder a cada imágen Docker desde una terminal diferente:

 ```
docker run -it --name=Radius1 --hostname=Radius1 richardqa/radius3-vmlocal /bin/bash
docker run -it --name=Radius2 --hostname=Radius2 richardqa/radius3-vmlocal2 /bin/bash
docker run -it --name=Federado --hostname=Federado richardqa/radius3-federado /bin/bash
 ```
## Verificar que el Hostname de cada Docker corresponda a su dominio respectivo (Ver Figura)

 ```
radius3-VMLocal: 172.17.0.2 == radius.redclara.xy
radius3-VMLocal2: 172.17.0.4 == radius.redclara2.xy
radius3-federado: 172.17.0.3 == radius.federado.xy
 ```
## Verificar que el archivo */etc/hosts* de cada Docker tenga mapeado las IPs y Dominio de cada Servidor:
 ```
172.17.0.2 radius.redclara.xy
172.17.0.3 federado.redclara.xy
172.17.0.4 radius.redclara2.xy
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
Nota: 
1. Verificar que el servico LDAP esta activo:  *service slapd status*. Si no estuviera activo, usar *service slapd start*. El usuario de testing pre-configurado en LDAP es richardqa@redclara.pe (clave:inictel) para Radius1, e richardqa@redclara2.pe (clave: inictel) para Radius2

2. Activar el servico SSH de cada servidor Radius. Existe un usuario creado (user: richardqa,  clave: inictel). Acceder desde la consola al servidor Radius1 usando SSH,
 ```
ssh richardqa@172.17.0.2
radtest richardqa@redclara.pe inictel 127.0.0.1 0 eduroam   (Verificar OK)
radtest richardqa@redclara2.pe inictel 127.0.0.1 0 eduroam (Verificar OK)
 ```
