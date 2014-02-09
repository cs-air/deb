dev-deb
================================

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
```

fix & update:
```bash
#vim /etc/apt/sources.list
wget -O /etc/apt/sources.list https://raw.github.com/devotg/dev-deb/master/sources.list --no-check-certificate
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
wget -O ~/.vimrc https://raw.github.com/devotg/dev-deb/master/.vimrc --no-check-certificate
```

vpn
```bash
cat /dev/ppp
cat /dev/tun
wget https://raw.github.com/devotg/dev-deb/master/pptp.sh && sh pptp.sh
wget https://raw.github.com/devotg/dev-deb/master/pptpd.sh && sh pptpd.sh
```


virtualmin
```bash
wget -O virtualmin.sh http://software.virtualmin.com/gpl/scripts/install.sh && sh virtualmin.sh
```

chruby
```bash
wget -O chruby-0.3.8.tar.gz https://github.com/postmodern/chruby/archive/v0.3.8.tar.gz
tar -xzvf chruby-0.3.8.tar.gz && cd chruby-0.3.8/ && sudo make install && cd ~

wget -O ruby-install-0.3.4.tar.gz https://github.com/postmodern/ruby-install/archive/v0.3.4.tar.gz
tar -xzvf ruby-install-0.3.4.tar.gz && cd ruby-install-0.3.4/ && sudo make install && cd ~

ruby-install
ruby-install ruby

cat > /etc/profile.d/chruby.sh <<EOF
[ -n "$BASH_VERSION" ] || [ -n "$ZSH_VERSION" ] || return
 
source /usr/local/share/chruby/chruby.sh
source /usr/local/share/chruby/auto.sh

chruby_use /opt/rubies/ruby-2.1.0

EOF

sed -i '/.*shift/ i\
echo "$1" > ~/.ruby-version' /usr/local/share/chruby/chruby.sh

#wget -O /usr/local/share/chruby/chruby.sh https://raw2.github.com/postmodern/chruby/master/share/chruby/chruby.sh
```

passenger
```bash
chruby ruby && gem update --system && gem install passenger
passenger-install-apache2-module -a --languages 'ruby,python,nodejs,meteor'
```

config
```bash
mkdir /opt/skel && cp -r /etc/skel /opt/skel/default
```

```bash
   LoadModule passenger_module /var/lib/gems/1.9.1/gems/passenger-4.0.37/buildout/apache2/mod_passenger.so
   <IfModule mod_passenger.c>
     PassengerRoot /var/lib/gems/1.9.1/gems/passenger-4.0.37
     PassengerDefaultRuby /usr/bin/ruby1.9.1
   </IfModule>

   <VirtualHost *:80>
      ServerName www.yourhost.com
      # !!! Be sure to point DocumentRoot to 'public'!
      DocumentRoot /somewhere/public
      <Directory /somewhere/public>
         # This relaxes Apache security settings.
         AllowOverride all
         # MultiViews must be turned off.
         Options -MultiViews
      </Directory>
   </VirtualHost>

```
