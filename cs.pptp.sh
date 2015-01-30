#!/bin/bash
echo "
cat /dev/ppp
cat /dev/tun
wget https://raw.github.com/devotg/dev-deb/master/cs.pptp.sh && sh cs.pptp.sh
"
echo "######################################################"
echo "Enter username:" && read u
echo "Enter password:" && read p

apt-get update
apt-get install pptpd -y

cat >> /etc/pptpd.conf <<END
localip 10.10.10.10
remoteip 10.10.10.11-15
END

cat >> /etc/ppp/pptpd-options <<END
ms-dns 8.8.8.8
ms-dns 8.8.4.4
END

cat >> /etc/ppp/chap-secrets <<END
$u * $p *
END

service pptpd restart

cat > /etc/sysctl.d/pptpd <<END
net.ipv4.ip_forward=1
END
sysctl -p

iptables -t nat -A POSTROUTING -o eth0 -j MASQUERADE && iptables-save

echo
echo "######################################################"
echo "PPTP setup complete!"
echo "Username:$u ##### Password: $p"
echo "######################################################"
