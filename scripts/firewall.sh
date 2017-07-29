# Reglas IPTABLES para Freeradius
 
# Limpiar todas las reglas y bloquear todo!
 ```
iptables -F
iptables -P INPUT DROP
iptables -A INPUT -i lo -j ACCEPT
 ```
# Solamente aceptar 10 consultas ICMP (icmp-request) por segundo para prevenir los ataques del tipo *Flooding* 
 ```
iptables -A INPUT -p icmp --icmp-type echo-request -m limit --limit 10/s -j ACCEPT
iptables -A INPUT -p icmp --icmp-type echo-request -j DROP
iptables -A INPUT -p icmp -j ACCEPT
 ```
# Liberar las conexiones previamente establecidas
 ```
iptables -A INPUT -m state --state ESTABLISHED,RELATED -j ACCEPT
 ``` 
# Liberar acceso SSH
 ```
iptables -A INPUT -p tcp -m tcp --dport 22 -j ACCEPT
 ```
# ntp - servidor de hora
 ```
iptables -A INPUT -p udp -m udp --dport 123 -j ACCEPT
 ```
O arquivo acima descrito pode ser baixado através do seguinte comando:
wget https://svn.rnp.br/repos/CAFe/conf/firewall/firewall-rules -O /etc/default/firewall --no-check-certificate

O bloco abaixo apresenta o conteúdo do arquivo /etc/systemd/system/firewall.service:
 ```
[Unit]
Description=Firewall Basico - RNP/CAFe - v1.0
 
[Service]
Type=oneshot
RemainAfterExit=yes
ExecStart=/opt/rnp/firewall/firewall.sh start
ExecStop=/opt/rnp/firewall/firewall.sh stop
 
[Install]
WantedBy=multi-user.target
 ```

O arquivo acima descrito pode ser baixado através do seguinte comando:
wget https://svn.rnp.br/repos/CAFe/conf/openldap/ubuntu16/firewall-systemd -O /etc/systemd/system/firewall.service --no-check-certificate

O bloco abaixo apresenta o conteúdo do arquivo /opt/rnp/firewall/firewall.sh:

 ``` 
RULES_FILE="/etc/default/firewall"
RETVAL=0
# To start the firewall 
start() {
    # Termina se nao existe iptables 
    [ -x /sbin/iptables ] || exit 0
    # Arquivo com as regras propriamente ditas 
    if [ -f "$RULES_FILE" ]; then
        echo "Carregando regras de firewall ..."
        . $RULES_FILE
    else
        echo "Arquivo de regras inexistente: $RULES_FILE"
        stop
        RETVAL=1
    fi
    RETVAL=0
}
# To stop the firewall 
stop() {
 
    echo "Removendo todas as regras de firewall ..."
    iptables -P INPUT ACCEPT
    iptables -F
    iptables -X
    iptables -Z
    RETVAL=0
}
case $1 in
    start)
        start
        ;;
    stop)
        stop
        ;;
    restart)
        stop
        start
        ;;
    status)
        /sbin/iptables -L
        /sbin/iptables -t nat -L
        RETVAL=0
        ;;
    *)
        echo "Uso: $1 {start|stop|restart|status}"
        RETVAL=1;;
esac
exit $RETVAL
 ```
O arquivo acima descrito pode ser baixado através do seguinte comando:
Criar a pasta /opt/rnp/firewall/
 
wget https://svn.rnp.br/repos/CAFe/conf/openldap/ubuntu16/firewall-sh -O /opt/rnp/firewall/firewall.sh --no-check-certificate

Uma vez que os dois arquivos estejam nos locais apropriados, é necessário executar as seguintes linhas de comando:
chmod 755 /opt/rnp/firewall/firewall.sh
chmod 664 /etc/systemd/system/firewall.service
systemctl daemon-reload
systemctl enable firewall.service

Ao executar tais linhas serão atribuídas as devidas permissões aos arquivos e será configurado o firewall no systemd.

2.11. Para fazer a instalação do NTP é necessária a seguinte linha de comando:
apt-get -y install ntp

2.12. Após fazer a instalação é necessário modificar o arquivo /etc/ntp.conf que deverá ficar com o seguinte conteúdo:
# /etc/ntp.conf, configuracao do ntpd
 
# Atualizado em 01/04/2013 por Rui Ribeiro - rui.ribeiro@cafe.rnp.br
 
driftfile /var/lib/ntp/ntp.drift
statsdir /var/log/ntpstats/
 
statistics loopstats peerstats clockstats
filegen loopstats file loopstats type day enable
filegen peerstats file peerstats type day enable
filegen clockstats file clockstats type day enable
 
# Servidores ntp do nic.br
 ```
server a.ntp.br
server b.ntp.br
server c.ntp.br
 ```
# By default, exchange time with everybody, but don't allow configuration.
# See /usr/share/doc/ntp-doc/html/accopt.html for details.
 ```
restrict -4 default kod notrap nomodify nopeer noquery
restrict -6 default kod notrap nomodify nopeer noquery
 ``` 
# Local users may interrogate the ntp server more closely.
 ```
restrict 127.0.0.1
restrict ::1
 ``` 
# Para habilitar o servidor de hora para acesso a partir da rede
# local, altere a linha abaixo:
#broadcast 192.168.123.255

O arquivo acima descrito pode ser baixado através do seguinte comando:
wget https://svn.rnp.br/repos/CAFe/conf/ntp/ntp.conf -O /etc/ntp.conf --no-check-certificate


# Liberação do FreeRadius   UDP e TCP                         
iptables -A INPUT -p tcp -m tcp --dport 1812 -j ACCEPT
iptables -A INPUT -p tcp -m tcp --dport 1813 -j ACCEPT
iptables -A INPUT -p tcp -m tcp --dport 1814 -j ACCEPT
iptables -A INPUT -p tcp -m tcp --dport 18120 -j ACCEPT
iptables -A INPUT -p tcp -m tcp --dport 2083 -j ACCEPT
iptables -A INPUT -p udp -m udp --dport 1812 -j ACCEPT
iptables -A INPUT -p udp -m udp --dport 1813 -j ACCEPT
iptables -A INPUT -p udp -m udp --dport 1814 -j ACCEPT
iptables -A INPUT -p udp -m udp --dport 18120 -j ACCEPT
iptables -A INPUT -p udp -m udp --dport 2083 -j ACCEPT

Finalmente, reinicie el Firewall

/etc/init.d/firewall restart

