# Creación de certificados digitales usando Openssl

Éste tutorial describe una de las formas de configurar certificados digitales X509 válidos para los servidores Radius de eduroam. Nosotros usamos Ubuntu 16.04 server, sin embargo estos pasos funcionan bien para cualquier otro sistema operativo tales como Debian o Centos. 

Para el buen entendimiento del curso se ha considerado lo siguiente que el dominio de su Institución sea **example.edu.uy**.

<a href="http://www.youtube.com/watch?feature=player_embedded&v=qk9aljqu20A
" target="_blank"><p align="center"><img src="https://github.com/richardqa/curso-eduroam/blob/master/imagenes/eduroam_gpg2.png" alt="IMAGE ALT TEXT HERE" width="660" height="360" border="10" /></p></a>

## Configuración de una Autoridad Certificadora privada

Los siguientes pasos muestran la forma de como crear los requisitos de certificados necesarios para el Radius

1. Creamos una carpeta llamada "newcerts" el cual almacenará todos los archivos necesarios para crear la solicitud del certificado digital para el Radius Local. Dentro de "newcerts" crearemos otra carpeta llamada "private", el cual contendrá las llaves privadas de los certificados a crearse.

```
mkdir -p newcerts/private
cd newcerts    
```
  
2. Creamos una llave privada llamada *radius.key* de 4096 bits usando el algoritmo simétrico AES de 256 bits.
 
 ```
openssl genrsa -aes256 -out private/radius.key 4096
 ```

3. Creamos los archivos *Diffie-Hellman* y *Random* necesarios para el servidor Radius

 ```
openssl dhparam -out dh 1024 
dd if=/dev/urandom of=./random count=10 
touch index.txt
echo '01' > serial
 ```

4. Una Autoridad Certificadora (CA) fue previamente creada y actualmente esta administrada por la Red Académica de Uruguay (RAU). Descargue la clave pública de la Autoridad Certificadora aquí [ca.crt](https://www.github.com/richardqa/curso-eduroam/blob/master/modulos/certs/ca.crt). Esta CA tendrá como función la firma de certificados digitales para los servidores Radius que quiera conectarse a eduroam. Para ver el contenido de la clave pública del CA (*ca.crt*) creado, escribir en una nueva terminal lo siguiente:

 ```
openssl x509 -in ca.crt -noout -text
 ```

5. En este paso vamos a crear nuevo archivo llamado **radius.cnf** dentro de la carpeta **newcerts** creada en el paso 1. El contenido de éste archivo puede ser obtenido desde aquí [radius.cnf](https://www.github.com/richardqa/curso-eduroam/blob/master/modulos/certs/radius.cnf). Editamos **radius.conf** con la información relacionada a su servidor Radius Local.
 ```
[ req ]
prompt                  = no
distinguished_name      = server
x509_extensions         = v3_ca

[server]
countryName             = UY
stateOrProvinceName     = Montevideo
localityName            = Montevideo
organizationName        = RAU
emailAddress            = eduroam@rau.edu.uy
commonName              = radius.example.edu.uy

[v3_ca]
subjectKeyIdentifier   = hash
authorityKeyIdentifier = keyid:always,issuer:always
basicConstraints       = CA:true
extendedKeyUsage       = serverAuth, clientAuth
 ```

4. Una vez que tengamos nuestro archivo *radius.cnf* configurado correctamente y nuestra llave pública/privada, vamos a crear la solicitud de certificado de la siguiente forma:

 ```
openssl req -new -nodes -out radius.example.csr -key private/radius.key -config ./radius.cnf
 ```
Nota1: Se le pedirá que ingrese un password, digitar el password colocado en el paso 2 que es cuando creó la llave privada del Radius.
 
Nota: La palabra **example** de nuestra solicitud de certificado **radius.example.csr** debe ser reemplazado por el nombre de su **Institución**

5. Luego, enviamos la solicitud de certificado generada en el paso 4 (radius.example.csr) al siguiente correo: eduroam@rau.edu.uy. El instructor del curso luego firmará dicha solicitud de certificado con su llave privada y se les entregará firmado al correo que indique en el mensaje del correo.

6. Finalmente, los archivos *radius.key*, *radius.example.edu.uy* (certificado firmado por RAU), *random*, *dh*, *ca.crt* deberán ser colocados dentro de la carpeta **/usr/local/etc/raddb/certs/radsec/** del servidor freeradius. Si la carpeta radsec no existiese, crearla.

 ```
cd ~/newcerts
cp -r radius.key radius.example.edu.uy.crt random dh ca.crt /usr/local/etc/raddb/certs/radsec/
 ```

8. Una vez terminado los pasos anteriores, haz click en [modulo2](https://github.com/richardqa/curso-eduroam/blob/master/modulos/Configura-GPG.md) para continuar con la actividad 2.
