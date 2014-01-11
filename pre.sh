hostname -f
yum -y update
ln -sf /usr/share/zoneinfo/Asia/Chongqing /etc/localtime
mkdir /opt/skel
cp -r /etc/skel /opt/skel/default
