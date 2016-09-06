# Creación de certificados digitales

Los siguientes pasos demostrarán la manera correcta de como configurar los certificados digitales válidos para los servidores Radius de eduroam.


## Creación de un directorio en donde se encontrará almacenados los certificados digitales usados en el servidor RADIUS
```
cp /usr/share/doc/freeradius/examples/certs/* ~/certificados/
cd ~/certificados/
mkdir private newcerts 
touch index.txt  
echo '01' > serial 
```

## Creación de los archivos Diffie-Hellman y Random necesarios para el servidor Radius

```
openssl dhparam -out dh 1024 
dd if=/dev/urandom of=./random count=10 
```

## Creación de una Autoridad Certificadora privada en Openssl

Antes de crear nuestro CA, configuramos el archivo ca.cnf que se encuentra dentro de nuestra carpeta certificados. Este archivo ca.cnf contiene todos los parámetros de configuración necesarios para el CA.

Notar que por defecto el servidor del CA usará "sha256". A continuación se muestra los parámetros más importantes en la configuración del servidor Radius.

```
[certificate_authority]
countryName             = UY
stateOrProvinceName     = Montevideo
localityName            = Montevideo
organizationName        = RAU
emailAddress            = eduroam@seciu.edu.uy
commonName              = Autoridad Certificadora privada de RAU

```

Después de configurar adecuadamente los parámetros necesarios para el CA, crearemos nuestra propia CA tomando como referencia el archivo "ca.cnf" previamente editado.

```
openssl req -key private/ca.key -new -x509 -extensions v3_ca -out ca.crt -days 3650 -config ./ca.cnf
```


