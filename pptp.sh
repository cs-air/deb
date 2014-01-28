#!/bin/bash
#cat /dev/ppp
#cat /dev/tun
echo "
PPTP install script for an OpenVZ VPS, Tested on Debian 7
wget https://raw.github.com/devotg/dev-deb/master/pptp.sh && sh pptp.sh  && rm pptp.sh
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
apt-get install pptpd -y
#apt-get install -y iptables logrotate tar cpio perl

# config
rm -r /dev/ppp
mknod /dev/ppp c 108 0
cat >> /etc/ppp/pptpd-options <<END
ms-dns 8.8.8.8
ms-dns 8.8.4.4
END

# setting up pptpd.conf
echo "option /etc/ppp/pptpd-options" > /etc/pptpd.conf
echo "logwtmp" >> /etc/pptpd.conf
echo "localip 10.10.10.10" >> /etc/pptpd.conf
echo "remoteip 10.10.10.11-15" >> /etc/pptpd.conf

# adding new user
echo "$u	*	$p	*" >> /etc/ppp/chap-secrets

echo
echo "######################################################"
echo "Forwarding IPv4 and Enabling it on boot"
echo "######################################################"
cat >> /etc/sysctl.conf <<END
net.ipv4.ip_forward=1
END
sysctl -p

echo
echo "######################################################"
echo "Updating IPtables Routing and Enabling it on boot"
echo "######################################################"
iptables -t nat -A POSTROUTING -j SNAT --to $ip
# saves iptables routing rules and enables them on-boot
iptables-save > /etc/iptables.conf

cat > /etc/network/if-pre-up.d/iptables <<END
#!/bin/sh
iptables-restore < /etc/iptables.conf
END

chmod +x /etc/network/if-pre-up.d/iptables
cat >> /etc/ppp/ip-up <<END
ifconfig ppp0 mtu 1400
END

echo "Restarting PoPToP ####################################"
sleep 5
/etc/init.d/pptpd restart

echo
echo "######################################################"
echo "PPTP setup complete!"
echo "Connect to your VPS at $ip with these credentials:"
echo "Username:$u ##### Password: $p"
echo "######################################################"
