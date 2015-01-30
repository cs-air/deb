#!/bin/bash
echo "
cat /dev/ppp
cat /dev/tun
wget https://raw.github.com/devotg/dev-deb/master/cs.pptp.sh && sh cs.pptp.sh
"
echo "######################################################"
echo "Enter username:" && read u
echo "Enter password:" && read p
echo "Enter ip:" && read ip

# install
apt-get update
apt-get purge pptpd ppp bcrelay -y
rm -rf /etc/pptpd.conf
rm -rf /etc/ppp
rm -rf /etc/sysctl.d/pptpd
rm -rf /etc/iptables.conf
rm -rf /etc/network/if-pre-up.d/iptables
apt-get install pptpd -y

cat >> /etc/pptpd.conf <<END
localip 10.10.10.10
remoteip 10.10.10.11-15
END

cat >> /etc/ppp/pptpd-options <<END
ms-dns 8.8.8.8
ms-dns 8.8.4.4
noipx
END

cat >> /etc/ppp/chap-secrets <<END
$u * $p *
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
