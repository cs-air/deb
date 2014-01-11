cd ~
wget -O virtualmin-install.sh http://software.virtualmin.com/gpl/scripts/install.sh
sh virtualmin-install.sh
 
wget -O chruby-0.3.8.tar.gz https://github.com/postmodern/chruby/archive/v0.3.8.tar.gz
tar -xzvf chruby-0.3.8.tar.gz
cd chruby-0.3.8/
sudo make install
cd ~
 
wget -O ruby-install-0.3.4.tar.gz https://github.com/postmodern/ruby-install/archive/v0.3.4.tar.gz
tar -xzvf ruby-install-0.3.4.tar.gz
cd ruby-install-0.3.4/
sudo make install
cd ~
 
cat <<EOF > /etc/profile.d/chruby.sh
[ -n "$BASH_VERSION" ] || [ -n "$ZSH_VERSION" ] || return
 
source /usr/local/share/chruby/chruby.sh
source /usr/local/share/chruby/auto.sh
chruby ruby
EOF

sed -i '/.*chruby_use \"\$match\" \"\$\*\"/ a\
echo $1 > .ruby_version' /usr/local/share/chruby/chruby.sh
