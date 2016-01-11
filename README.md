dev-deb
================================

```bash
apt-get update
apt-get install -y dialog sudo apt-utils curl
apt-get upgrade -y

passwd
adduser cs
usermod -a -G sudo cs

apt-get install -y python build-essential
curl -sL https://deb.nodesource.com/setup_5.x | bash -
apt-get install -y nodejs

which python
npm config set python /usr/bin/python
npm -g --unsafe-perm install strongloop

npm cache clean
npm install -g --unsafe-perm ionic@beta

curl https://install.meteor.com/ | sh

echo "export LC_ALL=en_US.UTF-8" > ~/.bashrc
apt-get install locales
locale-gen en_US.UTF-8
dpkg-reconfigure locales

ionic start MyIonic2Project tutorial --v2 --ts
```
test
```bash
wget freevps.us/downloads/bench.sh -O - -o /dev/null|bash
df -h
free -m
dd if=/dev/zero of=test bs=64k count=16k conv=fdatasync && rm -f test

hostname -f
cat /etc/debian_version
cat /proc/cpuinfo
cat /etc/hosts
ifconfig
iptables -L
```

fix & update:
```bash
#vim /etc/apt/sources.list
wget -O /etc/apt/sources.list https://raw.github.com/devotg/dev-deb/master/sources.list
apt-get update
#apt-get install dialog
#dpkg-reconfigure debconf
apt-get upgrade
cat >> /etc/apt/preferences <<END
Package: sysvinit
Pin: release c=main
Pin-Priority: -1
END
apt-get dist-upgrade
apt-get autoremove
apt-get clean
dpkg-reconfigure tzdata
wget -O ~/.vimrc https://raw.github.com/devotg/dev-deb/master/.vimrc
```

vpn
```bash
cat /dev/ppp
cat /dev/tun
wget https://raw.github.com/cs-air/deb/master/pptp.sh && bash pptp.sh
```
