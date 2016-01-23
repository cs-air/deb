dev-deb
================================

```bash
dpkg-reconfigure tzdata

apt-get update
apt-get install -y dialog sudo apt-utils curl
apt-get upgrade -y

passwd
adduser cs
usermod -a -G sudo cs

apt-get install -y python build-essential

# Node.js v5.x:
# Using Ubuntu
curl -sL https://deb.nodesource.com/setup_5.x | sudo -E bash -
sudo apt-get install -y nodejs
# Using Debian, as root
curl -sL https://deb.nodesource.com/setup_5.x | bash -
apt-get install -y nodejs
# Node.js v4.x:
# Using Ubuntu
curl -sL https://deb.nodesource.com/setup_4.x | sudo -E bash -
sudo apt-get install -y nodejs
# Using Debian, as root
curl -sL https://deb.nodesource.com/setup_4.x | bash -
apt-get install -y nodejs

npm cache clean
which python
npm config set python /usr/bin/python
npm install -g ionic@beta --unsafe-perm

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
