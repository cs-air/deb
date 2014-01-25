dev-deb
================================

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

fix & update:

```
apt-get update
apt-get install dialog
#dpkg-reconfigure debconf
apt-get dist-upgrade
dpkg-reconfigure tzdata
#vim /etc/apt/sources.list
```

vpn shell

```
cat /dev/ppp
wget https://raw.github.com/cwaffles/ezpptp/master/ezpptp.sh && sh ezpptp.sh
```

get install.sh

```
wget https://raw.github.com/devotg/virtualmin-chruby-passenger-installer/master/install.sh
sh install.sh
rm install.sh
```

```bash
cd ~ && wget -O virtualmin-install.sh http://software.virtualmin.com/gpl/scripts/install.sh && sh virtualmin-install.sh
 
wget -O chruby-0.3.8.tar.gz https://github.com/postmodern/chruby/archive/v0.3.8.tar.gz && tar -xzvf chruby-0.3.8.tar.gz
cd chruby-0.3.8/ && sudo make install && cd ~

wget -O ruby-install-0.3.4.tar.gz https://github.com/postmodern/ruby-install/archive/v0.3.4.tar.gz && tar -xzvf ruby-install-0.3.4.tar.gz
cd ruby-install-0.3.4/ && sudo make install && cd ~

ruby-install ruby-2.1.0

cat <<EOF > /etc/profile.d/chruby.sh
[ -n "$BASH_VERSION" ] || [ -n "$ZSH_VERSION" ] || return
 
source /usr/local/share/chruby/chruby.sh
source /usr/local/share/chruby/auto.sh

chruby_use /opt/rubies/ruby-2.1.0

EOF

sed -i '/.*shift/ i\
echo "$1" > ~/.ruby-version' /usr/local/share/chruby/chruby.sh
```

ruby
```ruby
puts "hello"
```

