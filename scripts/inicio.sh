#!/bin/bash

echo "Instalación y configuración básica: ... "
apt-get install freeradius radsecproxy
mkdir ~/certificados/
cp /usr/share/doc/freeradius/examples/certs/* ~/certificados/
cd ~/certificados/
mkdir private newcerts
touch index.txt
echo '01' > serial

 
