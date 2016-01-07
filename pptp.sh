#!/bin/bash
echo "
cat /dev/ppp
cat /dev/tun
wget https://raw.github.com/cs-air/deb/master/pptp.sh && bash pptp.sh
"

function get_ip(){
  ip=`ifconfig | grep 'inet addr:'| grep -v '127.0.0.*' | cut -d: -f2 | awk '{ print $1}' | head -1`
}

function install_pptpd(){
  apt-get install pptpd 
}

function fix(){
#apt-get purge pptpd ppp bcrelay
#rm -rf /etc/pptpd.conf
#rm -rf /etc/ppp
#rm -rf /etc/sysctl.d/pptpd
#rm -rf /etc/iptables.rules
#rm -rf /etc/network/if-pre-up.d/iptables
#rm -rf /dev/ppp
#mknod /dev/ppp c 108 0}
}

function config_pptpd(){
cat >> /etc/pptpd.conf <<END
localip 192.168.0.1
remoteip 192.168.0.34-40
END
cat >> /etc/ppp/pptpd-options <<END
ms-dns 8.8.8.8
ms-dns 8.8.4.4
END
}

function add_user(){
echo "Enter username:" && read u
echo "Enter password:" && read p
cat >> /etc/ppp/chap-secrets <<END
$u * $p *
END
}

function ip_forward(){
cat > /etc/sysctl.d/ip_forward <<END
net.ipv4.ip_forward=1
END
sysctl -p
}

function config_iptables(){
iptables -t nat -A POSTROUTING -j SNAT --to-source $ip
iptables-save > /etc/iptables.rules
cat > /etc/network/if-pre-up.d/iptables <<END
#!/bin/sh
iptables-restore < /etc/iptables.rules
END
chmod +x /etc/network/if-pre-up.d/iptables
}

function restart_pptpd(){
sleep 5
/etc/init.d/pptpd restart
}

function show_info(){
echo "######################################################"
echo "PPTP setup complete!"
echo "Connect to your VPS at $ip with these credentials:"
echo "Username:$u ##### Password: $p"
echo "######################################################"
}
