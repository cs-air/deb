dev-deb
================================

get install.sh

```
wget https://raw.github.com/devotg/virtualmin-chruby-passenger-installer/master/install.sh
sh install.sh
rm install.sh
```

Fix & Update:

```
dpkg-reconfigure tzdata
apt-get update
apt-get install dialog
#dpkg-reconfigure debconf
apt-get dist-upgrate
```

vps testing

```
wget freevps.us/downloads/bench.sh -O - -o /dev/null|bash
df -h
free -m
dd if=/dev/zero of=test bs=64k count=16k conv=fdatasync

hostname -f
cat /etc/debian_version
cat /proc/cpuinfo
```

vpn

```
wget https://raw.github.com/cwaffles/ezpptp/master/ezpptp.sh
sh ezpptp.sh
```
