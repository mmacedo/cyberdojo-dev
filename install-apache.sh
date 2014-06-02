#!/usr/bin/env bash
set -e # Exit on error

# http://help.discretelogix.com/ruby-rails/installing-apache-ruby-mysql-passenger-ubuntu-14-04.htm

# Install apache
apt-get install -y apache2
a2enmod rewrite

# Install sqlite3
apt-get install -y libsqlite3-dev

# Install passenger
apt-get install -y libcurl4-openssl-dev libssl-dev apache2-threaded-dev libapr1-dev libaprutil1-dev
gem install passenger

# Install passenger module (http://www.modrails.com/documentation/Users%20guide%20Apache.html#install_on_debian_ubuntu)
apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 561F9B9CAC40B2F7
apt-get install apt-transport-https ca-certificates
echo "deb https://oss-binaries.phusionpassenger.com/apt/passenger trusty main" > /etc/apt/sources.list.d/passenger.list
apt-get update
apt-get install -y libapache2-mod-passenger
a2enmod passenger

# Configure locale
echo <<SCRIPT
export LANGUAGE=en_US.UTF-8
export LANG=en_US.UTF-8
export LC_ALL=en_US.UTF-8
locale-gen en_US.UTF-8
dpkg-reconfigure locales
SCRIPT >> ~/.bash_profile
source ~/.bash_profile

# Listen to port 3000
sed -i '/Listen 80/ a\Listen 3000' /etc/apache2/ports.conf

# Restart apache2
service apache2 restart
