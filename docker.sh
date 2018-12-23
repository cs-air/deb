apt-get remove docker docker-engine docker.io
uname -r
apt-get update
apt-get install -y apt-transport-https ca-certificates curl gnupg2 software-properties-common
curl -fsSL https://download.docker.com/linux/debian/gpg | apt-key add -
apt-key fingerprint 0EBFCD88
#9DC8 5822 9FC7 DD38 854A E2D8 8D81 803C 0EBF CD88
add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/debian $(lsb_release -cs) stable"
apt-get update
apt-get install -y docker-ce
#apt-cache madison docker-ce
#apt-get install docker-ce=<VERSION_STRING>


docker pull hwdsl2/ipsec-vpn-server
wget -O vpn.env https://github.com/hwdsl2/docker-ipsec-vpn-server/blob/master/vpn.env.example
#edit vpn.env
docker run \
    --name vpn \
    --env-file ./vpn.env \
    --restart=always \
    -p 500:500/udp \
    -p 4500:4500/udp \
    -v /lib/modules:/lib/modules:ro \
    -d --privileged \
    hwdsl2/ipsec-vpn-server
    
