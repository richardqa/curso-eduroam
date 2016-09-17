# Creación de certificados digitales usando Openssl

Los siguientes pasos demostrarán una de las formas de como configurar los certificados digitales válidos para los servidores Radius de eduroam. Estos certificados serán creados dentro de su servidor Ubuntu 16.04 server.

## Configuración de una Autoridad Certificadora privada

Los pasos a continuación mostrarán la forma de como crear correctamente los certificados digitales para tu Radius Local.

1. Creación de una llave privada llamada *ca.key* de 4096 bits y usando el algoritmo simétrico AES de 256 bits.
 
 ```
openssl genrsa -aes256 -out private/ca.key 4096
 ```
2. Creación de los archivos *Diffie-Hellman* y *Random* necesarios para el servidor Radius

 ```
openssl dhparam -out dh 1024 
dd if=/dev/urandom of=./random count=10 
 ```
3. Creación de la Autoridad Certificadora privada (CA)

 Antes de crear nuestro CA, vamos a configurar el archivo *ca.cnf* que se encuentra dentro de nuestra carpeta *certificados* creado en el paso anterior (archivo [Readme](https://www.github.com/richardqa/curso-eduroam). Este archivo contiene todos los parámetros de configuración necesarios para la construcción de una CA privada.

 Notar que por defecto el servidor del CA usa el Hash de tipo "sha256". También notamos que las líneas **input_password** y **output_password** son comentadas porque el *passphrase* usado por el CA será generado usando *Openssl*. Finalmente, vemos que en el bloque **[certificate_authority]** se ha configurado los parámetros para su institución, en este caso RAU. 

 A continuación se muestra los parámetros más importantes en la configuración del servidor Radius.

 ```
[ req ]
prompt                  = no
distinguished_name      = certificate_authority
default_bits            = 2048
# input_password        = whatever
# output_password       = whatever
x509_extensions         = v3_req

[certificate_authority]
countryName             = **<dominio-pais>**
stateOrProvinceName     = **<ciudad>**
localityName            = **<ciudad>**
organizationName        = **<nombre-organización>**
emailAddress            = eduroam@**<dominio-organización>**
commonName              = Autoridad Certificadora privada de **<nombre-institución>**
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
openssl genrsa -aes256 -out private/radius1.key 4096
 ```

2. Estos pasos serían necesarios si aún no se han creado los archivos **Diffie-Hellman** y **Random** del paso 2 necesarios para el servidor Radius

 ```
openssl dhparam -out dh 1024 
dd if=/dev/urandom of=./random count=10 
 ```
3. En este paso vamos a crear una copia del archivo **server.cnf** a **radius1.cnf** y editamos este último con la información relacionada al servidor Radius. Notar que se ha comentado las líneas que empiezan con `input_password` y `output_password`. Tambien notamos que se ha agregado todo el bloque [v3_ca].


 ```
[ req ]
prompt                  = no
distinguished_name      = server
default_bits            = 2048
# input_password         = whatever
# output_password        = whatever
x509_extensions         = v3_ca  # Notar que esta línea fue agregado al bloque [req]

[server]
countryName             = **<dominio-pais>**
stateOrProvinceName     = **<ciudad>**
localityName            = **<ciudad>**
organizationName        = **<nombre-organización>**
emailAddress            = eduroam@**<dominio-organización>**
commonName              = radius.**dominio-institución>**

[v3_ca]
subjectKeyIdentifier    = hash
authorityKeyIdentifier  = keyid:always,issuer:always
basicConstraints        = CA:true
extendedKeyUsage        = serverAuth, clientAuth

 ```
4. Una vez que tengamos nuestro archivo `radius1.cnf` configurado correctamente, vamos a crear una solicitud de certificado de la siguiente forma:

 ```
openssl req -new -nodes -out radius1.csr -key private/radius.key -config ./radius1.cnf
 ```

5. Luego, firmamos la solicitud del certificado usando el CA creado previamente.

 ```
openssl ca -out radius.seciu1.edu.uy.crt -keyfile private/ca.key -config ./ca.cnf -infiles radius1.csr 
 ```

6. Los archivos `radius1.key`, `radius.seciu1.edu.uy.crt`, `random`, `dh`, `ca.crt` serán colocado dentro de la carpeta `certs` del servidor freeradius.

 ```
cp ~/certificados radius1.key radius.seciu1.edu.uy.crt random dh ca.crt /etc/freeradius/certs/
 ```

