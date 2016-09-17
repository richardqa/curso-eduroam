# Nuevo curso de *eduroam* para instituciones de Latino América

# Introducción (Falta completar)
Este curso esta dirigido a ...

## Configuración de las maquinas virtuales para el curso

Pre-requisito:

1. Instalar un **X Server** y un terminal con capacidad de Cliente SSH.
1.1 

A través de la aplicación __putty__ em Windows o el terminal de comandos de Linux, cada usuario se deberá conectar al servidor Radius de su Institución.

2. Para los usuarios que no consigan conectarse remotamente a su servidor, podrán descargar su imagen en Docker el cual viene ya pre-configurado los paquetes necesarios para su uso. Algunas referencias de la instalación y configuración de Docker en Linux [1].

3. Instalar GIT desde [2]

4. 


Para conseguir usar las maquinas virtuales pre-configuradas en Docker, es necesario instalar docker en su computador (Docker soporta Linux, Mac y Windows)

```

apt-get install docker

```

Las imagenes en Docker pueden ser descargadas aqui:

```
docker pull richardqa/curso-eduroam-radius1:v1
docker pull richardqa/curso-eduroam-radius2:v1
docker pull richardqa/curso-eduroam-proxy:v1

```

Los programas que se necesitan instalarse previamente son:

apt-get install rsyslog 


