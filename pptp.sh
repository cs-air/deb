#!/bin/bash
function install_pptp(){
echo "
cat /dev/ppp
cat /dev/tun
wget https://raw.github.com/cs-air/deb/master/pptp.sh && bash pptp.sh
"
echo "1)Add User;2)ReInstall;*)Install:"
read -p "your choice(1 or 2):" choice
if [ "$choice" = "1" ]; then
get_ip
add_user
restart_pptpd
show_info
elif [ "$choice" = "2" ]; then
  reinstall_pptpd
else
  install_pptpd
fi
}

function reinstall_pptpd(){
apt-get -y purge pptpd ppp bcrelay iptables
rm -rf /etc/pptpd.conf
rm -rf /etc/ppp
rm -rf /etc/sysctl.d/ip_forward
rm -rf /etc/iptables.rules
rm -rf /etc/network/if-pre-up.d/iptables
rm -rf /etc/rc.local
fix_ppp
install_pptpd
}

function install_pptpd(){
  apt-get install -y pptpd iptables
  get_ip
  config_pptpd
  add_user
  ip_forward
  config_iptables
  restart_pptpd
  show_info
}

function fix_ppp(){
rm -rf /dev/ppp
mknod /dev/ppp c 108 0
cat > /etc/rc.local <<END
rm -rf /dev/ppp
mknod /dev/ppp c 108 0
/etc/init.d/pptpd restart
END
}

function fix_pptpd(){
apt-get -y purge pptpd ppp bcrelay iptables
rm -rf /etc/pptpd.conf
rm -rf /etc/ppp
rm -rf /etc/sysctl.d/ip_forward
rm -rf /etc/iptables.rules
rm -rf /etc/network/if-pre-up.d/iptables
rm -rf /dev/ppp
mknod /dev/ppp c 108 0
}

function get_ip(){
  ip=`ifconfig | grep 'inet addr:'| grep -v '127.0.0.*' | cut -d: -f2 | awk '{ print $1}' | head -1`
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
#iptables -t nat -A POSTROUTING -j SNAT --to-source $ip
iptables -t nat -A POSTROUTING -s 192.168.0.0/24 -j SNAT --to-source $ip
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
echo "Connect to your VPS at $ip with these credentials:"
echo "Username:$u ##### Password: $p"
echo "######################################################"
}

install_pptp
