hostname -f
ln -sf /usr/share/zoneinfo/Asia/Chongqing /etc/localtime

yum -y update
yum -y install gcc-c++ curl-devel httpd-devel

#rpm --import http://dl.fedoraproject.org/pub/epel/RPM-GPG-KEY-EPEL-6
#rpm -Kih http://dl.fedoraproject.org/pub/epel/6/i386/epel-release-6-8.noarch.rpm
yum install http://dl.fedoraproject.org/pub/epel/6/i386/epel-release-6-8.noarch.rpm
yum -y install libyaml-devel
