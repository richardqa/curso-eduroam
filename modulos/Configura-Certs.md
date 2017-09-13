# Creación de certificados digitales usando Openssl

Éste tutorial describe una de las formas de configurar certificados digitales X509 válidos para los servidores Radius de eduroam. Nosotros usamos Ubuntu 16.04 server, sin embargo estos pasos funcionan bien para cualquier otro sistema operativo. 

Para los objetivos del curso, se ha considerado lo siguiente: Top level del dominio pais como **UY**, nombre del estado o provincia como **Estado**, localidad como **Localidad**, organización como **EXAMPLE** y dominio de la organización como **example.edu.uy**.

<a href="http://www.youtube.com/watch?feature=player_embedded&v=qk9aljqu20A
" target="_blank"><p align="center"><img src="https://github.com/richardqa/curso-eduroam/blob/master/imagenes/eduroam_gpg2.png" alt="IMAGE ALT TEXT HERE" width="660" height="360" border="10" /></p></a>

## Configuración de una Autoridad Certificadora privada

Los siguientes pasos muestran la forma de como crear certificados digitales X509

1. Creamos una carpeta llamada "certificados", el cual almacenará todos los archivos necesarios para construir certificados digitales X509. Dentro de "certificados" crearemos otra carpeta llamada "private", el cual contendrá las llaves privadas de los certificados a crearse.

```
mkdir -p newcerts/private
cd newcerts    
```
  
2. Creación de una llave privada llamada *ca.key* de 4096 bits usando el algoritmo simétrico AES de 256 bits.
 
 ```
openssl genrsa -aes256 -out private/ca.key 4096
 ```

3. Creación de los archivos *Diffie-Hellman* y *Random* necesarios para el servidor Radius

 ```
openssl dhparam -out dh 1024 
dd if=/dev/urandom of=./random count=10 
touch index.txt
echo '01' > serial
 ```
4. Creación de la Autoridad Certificadora privada (CA)

 Antes de crear nuestro CA, vamos a editar un archivo de configuración llamado *ca.cnf* que puede ser descargado aquí [ca.cnf](https://www.github.com/richardqa/curso-eduroam/blob/master/modulos/certs/ca.cnf). Este archivo contiene todos los parámetros de configuración necesarios para la construcción de una CA privada.

Notar que por defecto los parámetros de configuración del CA usan el Hash "Sha256". El tiempo de caducidad de los certificados es de 3650 días. El contenido dentro del bloque **[certificate_authority]** tendrá que ser cambiado de acuerdo a la información correspondiente a su institución.

A continuación se muestra los parámetros más importantes en la configuración del servidor Radius.

 ```
[ req ]
prompt                  = no
distinguished_name      = certificate_authority
default_bits            = 2048
x509_extensions         = v3_req

[certificate_authority]
countryName             = UY
stateOrProvinceName     = Estado
localityName            = Localidad
organizationName        = EXAMPLE
emailAddress            = eduroam@example.edu.uy
commonName              = Autoridad Certificadora privada de **EXAMPLE**

[v3_ca]
subjectKeyIdentifier    = hash
authorityKeyIdentifier  = keyid:always,issuer:always
basicConstraints        = CA:true
crlDistributionPoints   = URI:http://www.example.com/example_ca.crl
extendedKeyUsage        = serverAuth, clientAuth

 ```
5. Luego, ejecutamos la herramienta *openssl* para la construcción de nuestra llave pública y el certificado digital para nuestro CA privado.

 ```
openssl req -key private/ca.key -new -x509 -extensions v3_ca -out ca.crt -days 3650 -config ./ca.cnf
 ```
6. Para ver el contenido del certificado *ca.crt* creado:
 ```
openssl x509 -in ca.crt -noout -text
 ```
## Configuración de certificados para el Radius Local

1. Similar al paso 1, vamos a crear un para de llaves pública/privada para el servidor Radius Local.

 ```
openssl genrsa -aes256 -out private/radius.key 4096
 ```

2. Éste paso sería necesario si aún no se han creado los archivos **Diffie-Hellman** y **Random** del paso 3 necesarios para la creación de un CA

 ```
openssl dhparam -out dh 1024 
dd if=/dev/urandom of=./random count=10
 ```
3. En este paso vamos a consultar el archivo que se encuentra aquí [radius.cnf](https://www.github.com/richardqa/curso-eduroam/blob/master/modulos/certs/radius.cnf). Copiamos el contenido y lo copiamos dentro de un nuevo archivo llamado: **radius.cnf** ubicado en ~/newcerts/radius.cnf. Finalmente, eeditamos **radius.conf** con la información relacionada al servidor Radius Local.
 ```
[ req ]
prompt                  = no
distinguished_name      = server
x509_extensions         = v3_ca

[server]
countryName             = UY
stateOrProvinceName     = Estado
localityName            = Localidad
organizationName        = EXAMPLE
emailAddress            = eduroam@example.edu.uy
commonName              = radius.example.edu.uy

[v3_ca]
subjectKeyIdentifier   = hash
authorityKeyIdentifier = keyid:always,issuer:always
basicConstraints       = CA:true
extendedKeyUsage       = serverAuth, clientAuth
 ```

4. Una vez que tengamos nuestro archivo *radius.cnf* configurado correctamente y nueva llave pública/privada, vamos a crear una solicitud de certificado de la siguiente forma:

 ```
openssl req -new -nodes -out radius.csr -key private/radius.key -config ./radius.cnf
 ```

5. Luego, firmamos la solicitud del certificado usando el CA creado previamente.

 ```
openssl ca -out radius.example.edu.uy.crt -keyfile private/ca.key -config ./ca.cnf -infiles radius.csr 
 ```

7. Los archivos *radius.key*, *radius.example.edu.xy.crt*, *random*, *dh*, *ca.crt* deberán ser colocados dentro de la carpeta **/usr/local/etc/raddb/certs/radsec/** del servidor freeradius.

 ```
cd ~/newcerts
cp -r radius.key radius.example.edu.uy.crt random dh ca.crt /usr/local/etc/raddb/certs/radsec/
 ```

8. Una vez terminado los pasos anteriores, haz click en [modulo2](https://github.com/richardqa/curso-eduroam/blob/master/modulos/Configura-GPG.md) para continuar con la actividad 2.
