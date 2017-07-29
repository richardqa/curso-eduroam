# Creación de certificados digitales usando Openssl

En los siguientes pasos se muestra una de las formas de como configurar los certificados digitales X509 válidos para los servidores Radius de eduroam. fueron probados en un servidor Ubuntu 16.04 server. Para los objetivos del curso se ha considerado lo siguiente: Top level del dominio pais como **XY**, nombre del estado o provincia como **Estado**, localidad como **Localidad**, organización como **EXAMPLE** y dominio de la organización como **example.com**.

## Configuración de una Autoridad Certificadora privada

Los pasos a continuación mostrarán la forma de como crear correctamente los certificados digitales para tu Radius Local.

1. Creación de una llave privada llamada *ca.key* de 4096 bits y usando el algoritmo simétrico AES de 256 bits.
 
 ```
mkdir certificados  // creación de la carpeta "certificados"
cd certificados     
mkdir private	    // creación de la carpeta "private" en donde se almacenerá las claves privadas
openssl genrsa -aes256 -out private/ca.key 4096	 	// Creación de la clave privada del CA de 4096 bits
 ```

2. Creación de los archivos *Diffie-Hellman* y *Random* necesarios para el servidor Radius

 ```
openssl dhparam -out dh 1024 
dd if=/dev/urandom of=./random count=10 
touch index.txt
echo '01' > serial
 ```
3. Creación de la Autoridad Certificadora privada (CA)

 Antes de crear nuestro CA, vamos a configurar el archivo *ca.cnf* que se encuentra dentro de nuestra carpeta *certificados* creado en el paso anterior (archivo [Readme](https://www.github.com/richardqa/curso-eduroam). Este archivo contiene todos los parámetros de configuración necesarios para la construcción de una CA privada.

 Notar que por defecto el servidor del CA usa el Hash de tipo "sha256". También notamos que las líneas **input_password** y **output_password** son comentadas porque el *passphrase* usado por el CA será generado usando *Openssl*. Finalmente, vemos que en el bloque **[certificate_authority]** se ha configurado los parámetros para su institución, en este caso RAU. 

 A continuación se muestra los parámetros más importantes en la configuración del servidor Radius.

 ```
[ req ]
prompt                  = no
distinguished_name      = certificate_authority
# default_bits            = 2048
# input_password        = whatever
# output_password       = whatever
x509_extensions         = v3_req

[certificate_authority]
countryName             = <Country-CC>
stateOrProvinceName     = <State>
localityName            = <Locality>
organizationName        = <Organization>
emailAddress            = eduroam@<Domain>
commonName              = Autoridad Certificadora privada de <NREN>
...
[v3_req]
basicConstraints        = CA:FALSE
subjectKeyIdentifier    = hash
extendedKeyUsage        = serverAuth, clientAuth
 ```
4. Luego, ejecutamos la herramienta *openssl* para la construcción de nuestra llave pública y el certificado digital para nuestro CA privado.

 ```
openssl req -key private/ca.key -new -x509 -extensions v3_ca -out ca.crt -days 3650 -config ./ca.cnf
 ```
5. Para ver el contenido del certificado *ca.crt* creado:
 ```
openssl x509 -in ca.crt -noout -text
 ```
## Configuración de certificados para el Radius Local

1. Similar al paso 1, vamos a crear un para de llaves pública/privada para el servidor Radius Local.

 ```
openssl genrsa -aes256 -out private/radius.key 4096
 ```

2. Éste paso 7 sería necesario si aún no se han creado los archivos **Diffie-Hellman** y **Random** del paso 2 necesarios para el servidor Radius

 ```
openssl dhparam -out dh 1024 
dd if=/dev/urandom of=./random count=10
 ```
3. En este paso vamos a consultar el archivo que se encuentra dentro del directorio ../certs/radius.cnf, luego editamos éste nuevo archivo *radius.conf* con la información relacionada al servidor Radius Local. 

 Similar al paso 3, el hash por defecto usado es "sha256". También fueron comentadas las líneas **default_bits**, **input_password** y **output_password**.

 ```
[ req ]
prompt                  = no
distinguished_name      = server
# default_bits            = 2048
# input_password         = whatever
# output_password        = whatever
x509_extensions         = v3_ca  # Notar que esta línea fue agregado al bloque [req]

[server]
countryName             = <Country-CC>
stateOrProvinceName     = <State>
localityName            = <Locality>
organizationName        = <Organization>
emailAddress            = eduroam@<domain>
commonName              = radius.<domain>

[v3_ca]
subjectKeyIdentifier    = hash
authorityKeyIdentifier  = keyid:always,issuer:always
basicConstraints        = CA:true
extendedKeyUsage        = serverAuth, clientAuth

 ```

4. Una vez que tengamos nuestro archivo *radius.cnf* configurado correctamente y nueva llave pública/privada, vamos a crear una solicitud de certificado de la siguiente forma:

 ```
openssl req -new -nodes -out radius.csr -key private/radius.key -config ./radius.cnf
 ```

5. Luego, firmamos la solicitud del certificado usando el CA creado previamente.

 ```
openssl ca -out radius.example.com.crt -keyfile private/ca.key -config ./ca.cnf -infiles radius.csr 
 ```

6. Similar a los pasos 3,4,5 usted va firmar un certificado con el CA. El certificado debe tener esta sintaxis: federado.key, federado.example.com.crt

7. Los archivos *radius.key*, *radius.<domain>.crt*, *random*, *dh*, *ca.crt* serán colocado dentro de la carpeta **certs** del servidor freeradius.

 ```
cp ~/certificados radius1.key radius.example.com.crt random dh ca.crt /etc/freeradius/certs/
 ```

8. Una vez terminado los pasos anteriores, haz click en [modulo2](https://github.com/richardqa/curso-eduroam/blob/master/modulos/actividad2.md) para continuar con la actividad 2.