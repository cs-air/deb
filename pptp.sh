#!/bin/bash
#cat /dev/ppp
#cat /dev/tun
echo "
PPTP install script for an OpenVZ VPS, Tested on Debian 7
rm -f pptp.sh && wget https://raw.github.com/devotg/dev-deb/master/pptp.sh && sh pptp.sh  && rm -f pptp.sh
"

echo "######################################################"
echo "Enter username:" && read u
echo "Enter password:" && read p

# get IP
ip=`ifconfig venet0:0 | grep 'inet addr' | awk {'print $2'} | sed s/.*://`

# install
apt-get update
apt-get purge pptpd ppp bcrelay -y
rm -rf /etc/pptpd.conf
rm -rf /etc/ppp
rm -rf /etc/sysctl.d/pptpd
rm -rf /etc/iptables.conf
rm -rf /etc/network/if-pre-up.d/iptables
apt-get install pptpd -y
#apt-get install -y iptables logrotate tar cpio perl

# config
#rm -r /dev/ppp
#mknod /dev/ppp c 108 0

cat >> /etc/pptpd.conf <<END
localip 10.10.10.10
remoteip 10.10.10.11-15
END

cat >> /etc/ppp/pptpd-options <<END
ms-dns 8.8.8.8
ms-dns 8.8.4.4
noipx
mtu 1490
mru 1490
END

cat >> /etc/ppp/chap-secrets <<END
$u  * $p  *
END

cat > /etc/sysctl.d/pptpd <<END
net.ipv4.ip_forward=1
END
sysctl -p

iptables -t nat -A POSTROUTING -j SNAT --to-source $ip
iptables-save > /etc/iptables.conf

cat > /etc/network/if-pre-up.d/iptables <<END
#!/bin/sh
iptables-restore < /etc/iptables.conf
END
chmod +x /etc/network/if-pre-up.d/iptables
cat > /etc/ppp/ip-up.d/pptpd <<END
ifconfig $1 mtu 1490
END

sleep 5
/etc/init.d/pptpd restart

echo
echo "######################################################"
echo "PPTP setup complete!"
echo "Connect to your VPS at $ip with these credentials:"
echo "Username:$u ##### Password: $p"
echo "######################################################"
