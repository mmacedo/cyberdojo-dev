#!/usr/bin/env bash
set -e # Exit on error

# http://help.discretelogix.com/ruby-rails/installing-apache-ruby-mysql-passenger-ubuntu-14-04.htm

# Install apache
apt-get install -y apache2
a2enmod rewrite

# Install sqlite3
apt-get install -y libsqlite3-dev

# Install passenger module (http://www.modrails.com/documentation/Users%20guide%20Apache.html#install_on_debian_ubuntu)
apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 561F9B9CAC40B2F7
apt-get install apt-transport-https ca-certificates
echo "deb https://oss-binaries.phusionpassenger.com/apt/passenger trusty main" > /etc/apt/sources.list.d/passenger.list
apt-get update
apt-get install -y libapache2-mod-passenger

# Make passenger use rvm
sed -i 's|PassengerDefaultRuby /usr/bin/ruby|PassengerDefaultRuby /usr/local/rvm/wrappers/ruby-2.1.2/ruby|' /etc/apache2/mods-available/passenger.conf

# Configure locale
cat <<EOF >> ~/.bash_profile
export LANGUAGE=en_US.UTF-8
export LANG=en_US.UTF-8
export LC_ALL=en_US.UTF-8
dpkg-reconfigure -f noninteractive locales
EOF
source ~/.bash_profile

# Listen to port 3000
sed -i '/Listen 80/ a\Listen 3000' /etc/apache2/ports.conf

# Add site
cat <<EOF > /etc/apache2/sites-available/cyberdojo.conf
<VirtualHost *:3000>
  ServerName 127.0.0.1
  RailsEnv Development
  DocumentRoot /var/www/cyberdojo/public
  <Directory /var/www/cyberdojo>
    AllowOverride ALL
    Order allow,deny
    Allow from all
  </Directory>
</VirtualHost>
EOF
a2ensite cyberdojo

# Restart apache2
service apache2 restart
