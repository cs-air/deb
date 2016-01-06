vim /etc/apt/sources.list
Ubuntu Sources List Generator
http://repogen.simplylinux.ch/

apt-get update
apt-get upgrade
apt-get dist-upgrade
apt-get autoremove
apt-get clean
dpkg-reconfigure tzdata

passwd

adduser cs
usermod -a -G sudo cs
visudo
# User privilege specification
root ALL=(ALL:ALL) ALL
cs ALL=(ALL:ALL) ALL

nano /etc/ssh/sshd_config
Port 53434

service ssh restart

https://www.digitalocean.com/community/tutorials/initial-server-setup-with-ubuntu-14-04
https://www.digitalocean.com/community/tutorials/initial-server-setup-with-debian-8

sudo apt-get install curl
curl -sL https://deb.nodesource.com/setup | sudo bash -
sudo apt-get install nodejs

sudo npm install -g gulp bower ionic cordova phonegap sails@beta

sudo apt-get install nginx git
sudo nginx -s reload
sudo service nginx restart

https://www.digitalocean.com/community/tutorials/how-to-set-up-nginx-server-blocks-virtual-hosts-on-ubuntu-14-04-lts
https://help.ubuntu.com/community/Nginx
