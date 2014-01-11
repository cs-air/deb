cd ~
chruby ruby
gem update --system
gem install passenger
passenger-install-apache2-module
