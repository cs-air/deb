wget -O /usr/local/share/chruby/chruby.sh https://raw2.github.com/postmodern/chruby/master/share/chruby/chruby.sh

wget http://pyyaml.org/download/libyaml/yaml-0.1.4.tar.gz
tar xzvf yaml-0.1.4.tar.gz
cd yaml-0.1.4
./configure --prefix=/usr/local
make
make install
