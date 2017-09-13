# Instalación del Freeradius 3.0.15

## Instalando los paquetes necessarios
apt-get install wget bzip2 gcc make libtalloc-dev libssl-dev libldap2-dev libhiredis-dev

## Descargar el paquete freeradius 3.0.15 desde el repositorio oficial

 ```
wget ftp://ftp.freeradius.org/pub/freeradius/freeradius-server-3.0.15.tar.bz2
tar -xjvf freeradius-server-3.0.15.tar.bz2
cd freeradius-server-3.0.15
 ```
## Instalar Freeradius
 ```
./configure
make
make install
 ```
## Iniciar Freeradius

 ```
radiusd -X
 ```
¿Apareció error?,  Desinstale la versión antigua del OpenSSL e instale su versión más reciente

## Parchar la versión actual del OpenSSL

 ```
apt-get purge openssl
apt-get autoremove && apt-get autoclean
wget --no-check-certificate https://www.openssl.org/source/openssl-1.0.2l.tar.gz
tar zxvf openssl-1.0.2l.tar.gz
cd openssl-1.0.2l
./config
make
make install
cp /usr/local/ssl/bin/openssl /usr/bin/
openssl version -a
 ```

## Corregir la vulnerabilidad de OpenSSL

Dentro do /usr/local/etc/raddb/radiusd.conf vamos a colar o seguinte dentro do bloco **security**:

 ```
    ...
    security {

           allow_core_dumps = no
           max_attributes = 200
           reject_delay = 1
           status_server = yes
           allow_vulnerable_openssl = 'CVE-2016-6304'
    ...
    }
 ```
Finalmente, para probar que nuestro radius esta correctamente instalado, executamos **radiusd -fxx -l stdout**. Deberías ver que no aparece algun error

Una vez instalado el Freeradius 3.0.15, haz click en [modulo4](https://github.com/richardqa/curso-eduroam/blob/master/modulos/Freeradius3.x/configuraciones/README.md) para iniciar la configuración del Radius Local.

<!--
## Versión Antigua (¡No usar esto!)

## Instalar éste programa
 ```
apt-get install software-properties-common python-software-properties
 ```
## Verificar que algun programa antiguo de freeradius esté instalado
 ```
apt-get purge libfreeradius2 freeradius-common; rm -rf /etc/freeradius
 ```
## Instalar el repositorio que contiene el freeradius 3.x
 ```
add-apt-repository ppa:freeradius/stable-3.0
 ```
## Click en Enter cuando te lo solicita
## Actualizar repositorio e instalar el freeradius 3.x
 ```
apt-get update
apt-get install freeradius
 ```
## Verificar la versión instalada del Freeradius
 ```
freeradius -v
   Freeradiusd: FreeRADIUS Version 3.0.12, for host x86_64-pc-linux-gnu, built on Dec  3 2016 at 15:55:32
 ```
-->
