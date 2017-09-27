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
root@radius:~# gpg2 --list-key
/home/radius/.gnupg/pubring.kbx
------------------------------
pub   rsa2048/6E1979B6 2017-09-27 [SC]
uid         [ultimate] Usuario Usuario <usuario@example.edu.uy>
sub   rsa2048/5A9A062F 2017-09-27 [E]
```

Para subir nuestra clave pública al Internet:
```
gpg2 --keyserver pgp.mit.edu --send-keys 0x6E1979B6
gpg2: sending key 1285BE5B to hkp server pgp.mit.edu
```
Nota: El ID **0x6E1979B6** es personal y diferente por cada clave GPG creado, por tanto reemplaza el código **6E1979B6** por el ID de su usuario.

En todo el Internet existen casi más de 8 servidores GPG, el cual podamos encontrar nuestra clave pública. El tiempo máximo para que las llaves puedan ser sincronizadas entre los servidores es de 5 minutos aproximadamente.

Para buscar nuestra llave pública, podemos usar lo siguiente:
```
gpg --keyserver pgp.mit.edu --search-keys 0x6E1979B6
gpg: keyring `/home/radius/.gnupg/secring.gpg' created
gpg: keyring `/home/radius/.gnupg/pubring.gpg' created
gpg: searching for "0x6E1979B6" from hkp server pgp.mit.edu
(1)	Usuario Usuario <usuario@example.edu.uy>
	  2048 bit RSA key 6E1979B6, created: 2017-09-27
Keys 1-1 of 1 for "0x6E1979B6".  Enter number(s), N)ext, or Q)uit > 
```

El motivo de usar GPG es que los administradores de los servidores Radius compartan la clave secreta con otro Radius de manera confiable. En tal sentido, es comun el uso de GPG en Thunderbirds y Engimail.

Las politicas globales de eduroam recomiendan el uso de claves de 16 caracteres y que sean creados aleatoriamente a través de un programa como por ejemplo *makepasswd*
```
makepasswd --chars=16
EBY2F4LLcjtxs0FQ
```
7. Una vez terminado los pasos anteriores, haz click en [Configura_Radius](https://github.com/richardqa/curso-eduroam/blob/master/modulos/Freeradius3.x/configuraciones/README.md) para iniciar la configuración del Radius Local.
