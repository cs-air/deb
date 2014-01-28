dev-deb
================================

vps testing
```bash
wget freevps.us/downloads/bench.sh -O - -o /dev/null|bash
df -h
free -m
dd if=/dev/zero of=test bs=64k count=16k conv=fdatasync

hostname -f
cat /etc/debian_version
cat /proc/cpuinfo
```

fix & update:
```bash
apt-get update
#apt-get install dialog
#dpkg-reconfigure debconf
apt-get dist-upgrade
apt-get autoremove
apt-get clean
dpkg-reconfigure tzdata
#vim /etc/apt/sources.list
```

vpn
```bash
cat /dev/ppp
cat /dev/tun
wget https://raw.github.com/devotg/dev-deb/master/pptp.sh && sh pptp.sh
```

get install.sh
```bash
wget https://raw.github.com/devotg/virtualmin-chruby-passenger-installer/master/install.sh
sh install.sh
rm install.sh
```

virtualmin&chruby
```bash
cd ~ && wget -O virtualmin-install.sh http://software.virtualmin.com/gpl/scripts/install.sh && sh virtualmin-install.sh
 
wget -O chruby-0.3.8.tar.gz https://github.com/postmodern/chruby/archive/v0.3.8.tar.gz && tar -xzvf chruby-0.3.8.tar.gz
cd chruby-0.3.8/ && sudo make install && cd ~

wget -O ruby-install-0.3.4.tar.gz https://github.com/postmodern/ruby-install/archive/v0.3.4.tar.gz && tar -xzvf ruby-install-0.3.4.tar.gz
cd ruby-install-0.3.4/ && sudo make install && cd ~

ruby-install
ruby-install ruby

cat <<EOF > /etc/profile.d/chruby.sh
[ -n "$BASH_VERSION" ] || [ -n "$ZSH_VERSION" ] || return
 
source /usr/local/share/chruby/chruby.sh
source /usr/local/share/chruby/auto.sh

chruby_use /opt/rubies/ruby-2.1.0

EOF

sed -i '/.*shift/ i\
echo "$1" > ~/.ruby-version' /usr/local/share/chruby/chruby.sh
```

passenger
```bash
cd ~
chruby ruby
gem update --system
gem install passenger
passenger-install-apache2-module -a --languages 'ruby,python,nodejs,meteor'
```

config
```bash
mkdir /opt/skel && cp -r /etc/skel /opt/skel/default
```
```bash
   LoadModule passenger_module /var/lib/gems/1.9.1/gems/passenger-4.0.36/buildout/apache2/mod_passenger.so
   <IfModule mod_passenger.c>
     PassengerRoot /var/lib/gems/1.9.1/gems/passenger-4.0.36
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
