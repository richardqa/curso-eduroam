# Creación de certificados digitales y archivos necesarios para la configuración del servidor Radius

Los siguientes pasos demostrarán una de las formas de como configurar los certificados digitales válidos para los servidores Radius de eduroam. Estos certificados serán configurados sobre el Host final.


## Configuración de una Autoridad Certificadora privada

1. Pasos previos: Creación de un directorio ** certificados ** y archivos necesarios para el CA.

```
cp /usr/share/doc/freeradius/examples/certs/* ~/certificados/
cd ~/certificados/
mkdir private newcerts 
touch index.txt  
echo '01' > serial 
```

2. Creación de una llave privada para el CA `ca.key` de 4096 bits usando el algoritmo simétrico AES de 256 bits.

```
openssl genrsa -aes256 -out private/ca.key 4096
```

3. Creación de los archivos ** Diffie-Hellman** y **Random** necesarios para el servidor Radius

```
openssl dhparam -out dh 1024 
dd if=/dev/urandom of=./random count=10 
```

4. Creación de una Autoridad Certificadora privada en Openssl

Antes de crear nuestro CA, vamos a configurar el archivo ca.cnf que se encuentra dentro de nuestra carpeta de certificados. Este archivo ca.cnf contiene todos los parámetros de configuración necesarios para la construcción de una CA privada.

Notar que por defecto el servidor del CA usará Hash del tip "sha256". A continuación se muestra los parámetros más importantes en la configuración del servidor Radius. Se han comentado algunas líneas usando "#".

```
[ req ]
prompt                  = no
distinguished_name      = certificate_authority
default_bits            = 2048
# input_password        = whatever
# output_password       = whatever
x509_extensions         = v3_req

[certificate_authority]
countryName             = UY
stateOrProvinceName     = Montevideo
localityName            = Montevideo
organizationName        = RAU
emailAddress            = eduroam@seciu.edu.uy
commonName              = Autoridad Certificadora privada de RAU
...
[v3_req]
basicConstraints        = CA:FALSE
subjectKeyIdentifier    = hash
extendedKeyUsage        = serverAuth, clientAuth

```

5. Después de configurar adecuadamente los parámetros necesarios para el CA, crearemos nuestro propia CA tomando como referencia el archivo "ca.cnf" previamente editado.


```
openssl req -key private/ca.key -new -x509 -extensions v3_ca -out ca.crt -days 3650 -config ./ca.cnf
```

La manera para leer el certificado digital es usando:

```
openssl x509 -in ca.crt -noout -text
```
## Configuración de los archivos SSL necesarios para la configuración del servidor Radius

1. Creación de una llave privada `radius1.key` de 4096 bits usando el algoritmo simétrico AES de 256 bits.

```
openssl genrsa -aes256 -out private/radius1.key 4096
```

2. Creación de los archivos ** Diffie-Hellman** y **Random** necesarios para el servidor Radius

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
countryName             = UY
stateOrProvinceName     = Montevideo
localityName            = Montevideo
organizationName        = RAU
emailAddress            = eduroam@seciu1.edu.uy
commonName              = radius.seciu1.edu.uy

[v3_ca]
subjectKeyIdentifier    = hash
authorityKeyIdentifier  = keyid:always,issuer:always
basicConstraints        = CA:true
extendedKeyUsage        = serverAuth, clientAuth

```
4. Una vez que tengamos nuestro archivo `radius1.cnf` listo, vamos a crear una solicitud de certificado de la siguiente forma:

```
openssl req -new -nodes -out radius1.csr -key private/radius.key -config ./radius1.cnf
```

5. Luego, firmamos la solicitud del certificado usando el CA creado previamente.

```
openssl ca -out radius.seciu1.edu.uy.crt -keyfile private/ca.key -config ./ca.cnf -infiles radius1.csr 
```

Los archivos `radius1.key`, `radius.seciu1.edu.uy.crt`, `random`, `dh`, `ca.crt` serán colocado dentro de la carpeta `certs` del servidor freeradius.




