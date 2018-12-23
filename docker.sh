apt-get remove docker docker-engine docker.io
uname -r
apt-get update
apt-get install apt-transport-https ca-certificates curl gnupg2 software-properties-common
curl -fsSL https://download.docker.com/linux/debian/gpg | sudo apt-key add -
apt-key fingerprint 0EBFCD88
#9DC8 5822 9FC7 DD38 854A E2D8 8D81 803C 0EBF CD88
add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/debian $(lsb_release -cs) stable"
apt-get update
apt-get install docker-ce
#apt-cache madison docker-ce
#apt-get install docker-ce=<VERSION_STRING>
