# Creación de llaves públicas y privadas GnuPG

El intercambio de claves GPG sirve para que los administradores de eduroam puedan intercambiar una misma clave compartida entre servidores Radius, lo cual permitiría que ambos Radius puedan verse como Cliente-Servidor.

Los siguientes pasos describirá los pasos necesarios para la creación de las llaves públicas/privadas usando GPGv2.

1. Verificar que el paquete "GPG" ou "GPGv2" se encuentre instalado. Tambien verificar que el paquete "rng-tools" se encuentre instalado. Si no estuviese instaldo, instale: 

```
apt-get install gpgv2 gnupg2 rng-tools
```

2. Crear las llaves pública/privada usando GPG

```
gpg2 --gen-key

gpg (GnuPG) 2.1.11; Copyright (C) 2016 Free Software Foundation, Inc.
This is free software: you are free to change and redistribute it.
There is NO WARRANTY, to the extent permitted by law.

gpg: directory '/home/radius/.gnupg' created
gpg: new configuration file '/home/radius/.gnupg/dirmngr.conf' created
gpg: new configuration file '/home/radius/.gnupg/gpg.conf' created
gpg: keybox '/home/cesar/.gnupg/pubring.kbx' created
Note: Use "gpg2 --full-gen-key" for a full featured key generation dialog.

GnuPG needs to construct a user ID to identify your key.

Real name: Usuario Usuario
Email address: usuario@example.edu.uy
You selected this USER-ID:
    "Usuario Usuario <usuario@example.edu.uy>"

Change (N)ame, (E)mail, or (O)kay/(Q)uit? O
We need to generate a lot of random bytes. It is a good idea to perform
some other action (type on the keyboard, move the mouse, utilize the
disks) during the prime generation; this gives the random number
generator a better chance to gain enough entropy.
```

Luego, te aparecerá un cuadro para que ingrese una contraseña segura. Caso contrario le pedirá que vuelva ingresa la contraseña.

**Nota**: Para algunas versiones de GPGv2 te pide que ingreses el tipo de clave, el cual deberían ingresar la opción 1 que es el default (RSA). También pueden pedir que ingrese la duración en días de la clave GPG, el cual se sugiere que sea mayor de 1 año. Si les pidiese que ingrese más entropia para generar las clave pública/privada, una forma efectiva de generar entropia es mediante el uso de la herramienta *rng-tools* el cual genera datos *random* desde el Hardware al Kernel. Por ejemplo, desde otra terminal usar:

```
rngd -r /dev/urandom

```
Y desde la primera terminal vemos que se generó suficiente entropia para la generación de claves GPG.

```
...+++++
.....+++++
gpg: key 1285BE5B marked as ultimately trusted
public and secret key created and signed.

gpg: checking the trustdb
gpg: 3 marginal(s) needed, 1 complete(s) needed, PGP trust model
gpg: depth: 0  valid:   1  signed:   0  trust: 0-, 0q, 0n, 0m, 0f, 1u
pub   2048R/1285BE5B 2016-09-10
      Key fingerprint = FD2D CFB2 E2B3 6F81 90DC  5ABB BE63 1B0A 1285 BE5B
uid                  Usuario administrador de eduroam <usuario@example.edu.uy>
sub   2048R/D65F9703 2016-09-10
```
Para listar las claves que nuestra llavero GPG cuenta:
```
gpg2 --list-key
/root/.gnupg/pubring.gpg
------------------------
pub   2048R/1285BE5B 2016-09-10
uid                  Usuario administrador de eduroam <usuario@example.edu.uy>
sub   2048R/D65F9703 2016-09-10
```
Para subir nuestra clave pública al Internet:
```
gpg2 --keyserver pgp.mit.edu --send-keys 0x1285BE5B
gpg2: sending key 1285BE5B to hkp server pgp.mit.edu
```
En todo el Internet existen casi más de 8 servidores GPG, en el cual podamos encontrar nuestra clave pública. El tiempo máximo para que las llaves puedan ser sincronizadas entre los servidores es de 3 minutos.

Para buscar nuestra llave pública, podemos usar lo siguiente:
```
gpg --keyserver pgp.mit.edu --search-keys 0x1285BE5B   
gpg: searching for "0x1285BE5B" from hkp server pgp.mit.edu
(1)	Usuario administrador de eduroam <eduroam@institucion.edu.uy>
	  2048 bit RSA key 1285BE5B, created: 2016-09-10
Keys 1-1 of 1 for "0x1285BE5B".  Enter number(s), N)ext, or Q)uit > 1
gpg: requesting key 1285BE5B from hkp server pgp.mit.edu
gpg: key 1285BE5B: "Usuario administrador de eduroam <eduroam@institucion.edu.uy>" not changed
gpg: Total number processed: 1
gpg:              unchanged: 1
```
El motivo de usar GPG es que los administradores de los servidores Radius compartan la clave secreta con otro Radius de manera confiable. En tal sentido, es comun el uso de GPG, Thunderbirds y Engimail.

Las politicas globales de eduroam recomiendan el uso de claves de 16 caracteres y que sean creados aleatoriamente a través de un programa como por ejemplo *makepasswd*
```
makepasswd --chars=16
EBY2F4LLcjtxs0FQ
```
7. Una vez terminado los pasos anteriores, haz click en [modulo3](https://github.com/richardqa/curso-eduroam/blob/master/modulos/Freeradius3.x/freeradius3-install.md) para continuar con la actividad de instalación del Freeradius 3.0.15.
