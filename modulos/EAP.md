### Configuración de Métodos de Autenticación TTLS para Radius Local

1. Como primer paso vamos a verificar que todos los administradores de servidores Radius hayan recibido el certificado digital firmado por la RAU.

2. Una vez recibido el certificado digital (e.g., "radius.example.edu.uy.crt"), copiamos dicho certificado junto con los otros archivos "radius.key", "dh", "random" y "ca.crt" y lo pegamos en el directorio **/usr/local/etc/raddb/certs/radsec/**. Si en caso el directorio **radsec** no se encuentre creado, lo crean con **mkdir /usr/local/etc/raddb/certs/radsec/**.

```
cd ~/newcerts
cp -r radius.key radius.example.edu.uy.crt random dh ca.crt /usr/local/etc/raddb/certs/radsec/
```
3. Configuremos los tipos EAP soportados por el protocolo Radius (TTLS, PEAP, etc). Para configurar estos procolos tenemos que editar el siguiente archivo **/usr/local/etc/raddb/mods-available/eap** cambiando las líneas correspondientes a los certificados digitales que soporta TLS de Radius tal como es mostrado debajo: 

```
168         #  Note that you should NOT use a globally known CA here!
169         #  e.g. using a Verisign cert as a "known CA" means that
170         #  ANYONE who has a certificate signed by them can
171         #  authenticate via EAP-TLS!  This is likely not what you want.
172         tls-config tls-common {
173                 private_key_password = <clave-privada-radius>
174                 private_key_file = ${certdir}/radsec/private/radius.key
175 
176                 #  If Private key & Certificate are located in
177                 #  the same file, then private_key_file &
178                 #  certificate_file must contain the same file
179                 #  name.
180                 #
181                 #  If ca_file (below) is not used, then the
182                 #  certificate_file below MUST include not
183                 #  only the server certificate, but ALSO all
184                 #  of the CA certificates used to sign the
185                 #  server certificate.
186                 certificate_file = ${certdir}/radius.example.edu.uy.crt
187 
188                 #  Trusted Root CA list
189                 #
190                 #  ALL of the CA's in this list will be trusted
191                 #  to issue client certificates for authentication.
192                 #
193                 #  In general, you should use self-signed
194                 #  certificates for 802.1x (EAP) authentication.
195                 #  In that case, this CA file should contain
196                 #  *one* CA certificate.
197                 #
198                 ca_file = ${cadir}/ca.crt
199 
200                 #  OpenSSL will automatically create certificate chains,
201                 #  unless we tell it to not do that.  The problem is that
202                 #  it sometimes gets the chains right from a certificate
203                 #  signature view, but wrong from the clients view.
204                 #
205                 #  When setting "auto_chain = no", the server certificate
206                 #  file MUST include the full certificate chain.
207         #       auto_chain = yes
208 
209                 #
210                 #  If OpenSSL supports TLS-PSK, then we can use
211                 #  a PSK identity and (hex) password.  When the
212                 #  following two configuration items are specified,
213                 #  then certificate-based configuration items are
214                 #  not allowed.  e.g.:
215                 #
216                 #       private_key_password
217                 #       private_key_file
218                 #       certificate_file
219                 #       ca_file
220                 #       ca_path
221                 #
222                 #  For now, the identity is fixed, and must be the
223                 #  same on the client.  The passphrase must be a hex
224                 #  value, and can be up to 256 hex digits.
225                 #
226                 #  Future versions of the server may be able to
227                 #  look up the shared key (hexphrase) based on the
228                 #  identity.
229                 #
230         #       psk_identity = "test"
231         #       psk_hexphrase = "036363823"
232 
233                 #
234                 #  For DH cipher suites to work, you have to
235                 #  run OpenSSL to create the DH file first:
236                 #
237                 #       openssl dhparam -out certs/dh 2048
238                 #
239                 dh_file = ${certdir}/radsec/dh
240 
241                 #
242                 #  If your system doesn't have /dev/urandom,
243                 #  you will need to create this file, and
244                 #  periodically change its contents.
245                 #
246                 #  For security reasons, FreeRADIUS doesn't
247                 #  write to files in its configuration
248                 #  directory.
249                 #
250         #       random_file = /dev/urandom

```

Como verán en la configuración de arriba, las únicas líneas a ser modificadas son las 173,174,186,198,239. En la línea 186 es necesario cambiar el nombre del certificado digital (radius.example.edu.uy.crt) por el nombre del certificado digital que le fue entregado.

El método de autenticación por defecto será EAP-TTLS. Este método es enviado por el servidor RADIUS en respuesta al mensaje "EAP-Response, Identity" por parte del usuario. Por otro lado, también es necesario configurar un tiempo de expiración para las correlaciones entre los mensajes “EAP-Request” y “EAP-Response”. El valor por defecto es de 60 segundos.

Nota 1: Recuerde que cada cambio que realiza **Reiniciar su servidor Radius**. Se sugiere que se reinicie desde el modo **debug**

```
radiusd -fxx -l stdout
```

Nota 2: Si en caso el puerto del servidor Radius esta en **uso**, entonces matamos el proceso del Radius y lo reiniciamos nuevamos.
```
ps aux |grep radiusd
kill -9 <proceso_radius_encontrado>
```
