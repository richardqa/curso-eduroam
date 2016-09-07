# Creación de certificados digitales en Ubuntu 16.04 server

Los siguientes pasos demostrarán una de las formas de como configurar los certificados digitales válidos para los servidores Radius de eduroam. Estos certificados serán configurados sobre el Host final.


## Creación de un directorio de certificados y archivos necesarios para el CA
```
cp /usr/share/doc/freeradius/examples/certs/* ~/certificados/
cd ~/certificados/
mkdir private newcerts 
touch index.txt  
echo '01' > serial 
```

## Creación de una llave privada de 4096 bits usando el algoritmo simétrico AES de 256 bits.
```
openssl genrsa -aes256 -out private/ca.key 4096
```

## Creación de los archivos Diffie-Hellman y Random necesarios para el servidor Radius

```
openssl dhparam -out dh 1024 
dd if=/dev/urandom of=./random count=10 
```

## Creación de una Autoridad Certificadora privada en Openssl

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

Después de configurar adecuadamente los parámetros necesarios para el CA, crearemos nuestro propia CA tomando como referencia el archivo "ca.cnf" previamente editado.

```
openssl req -key private/ca.key -new -x509 -extensions v3_ca -out ca.crt -days 3650 -config ./ca.cnf
```

La manera para leer el certificado digital es usando:

```
openssl x509 -in ca.crt -noout -text
```


