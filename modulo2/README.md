# Creación de llaves públicas y privadas GnuPG

El intercambio de claves GPG sirve para que los administradores de eduroam puedan intercambiar una misma clave compartida entre servidores Radius, lo cual permitiría que ambos Radius puedan verse como Cliente-Servidor.

Para este ejercicio se recomienda que la creación de llaves sea ejecutado desde un computador con modo gráfico, porque ...

1. Verificar que el paquete "GPG" ou "GPGv2" se encuentre instalado. Tambien verificar que el paquete "rng-tools" se encuentre instalado.

2. Crear las llaves pública/privada usando GPG

```
gpg --gen-key

gpg (GnuPG) 1.4.20; Copyright (C) 2015 Free Software Foundation, Inc.

This is free software: you are free to change and redistribute it.
There is NO WARRANTY, to the extent permitted by law.

Please select what kind of key you want:
   (1) RSA and RSA (default)
   (2) DSA and Elgamal
   (3) DSA (sign only)
   (4) RSA (sign only)
Your selection? 1
RSA keys may be between 1024 and 4096 bits long.
What keysize do you want? (2048) 
Requested keysize is 2048 bits
Please specify how long the key should be valid.
         0 = key does not expire
      <n>  = key expires in n days
      <n>w = key expires in n weeks
      <n>m = key expires in n months
      <n>y = key expires in n years
Key is valid for? (0) 
Key does not expire at all
Is this correct? (y/N) y

You need a user ID to identify your key; the software constructs the user ID
from the Real Name, Comment and Email Address in this form:
    "Heinrich Heine (Der Dichter) <heinrichh@duesseldorf.de>"

Real name: Usuario administrador de eduroam
Email address: eduroam@institucion.edu.uy
Comment: 
You selected this USER-ID:
    "Usuario administrador de eduroam <eduroam@institucion.edu.uy>"

Change (N)ame, (C)omment, (E)mail or (O)kay/(Q)uit? O
You need a Passphrase to protect your secret key.

gpg: gpg-agent is not available in this session
We need to generate a lot of random bytes. It is a good idea to perform
some other action (type on the keyboard, move the mouse, utilize the
disks) during the prime generation; this gives the random number
generator a better chance to gain enough entropy.

Not enough random bytes available.  Please do some other work to give
the OS a chance to collect more entropy! (Need 57 more bytes)
..............+++++
......+++++
We need to generate a lot of random bytes. It is a good idea to perform
some other action (type on the keyboard, move the mouse, utilize the
disks) during the prime generation; this gives the random number
generator a better chance to gain enough entropy.

```
Una forma efectiva de generar entropia es mediante el uso de la herramienta *rng-tools* el cual genera datos *random* desde el Hardware al Kernel. Por ejemplo, desde otra terminal usar:

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
uid                  Usuario administrador de eduroam <eduroam@institucion.edu.uy>
sub   2048R/D65F9703 2016-09-10
```
