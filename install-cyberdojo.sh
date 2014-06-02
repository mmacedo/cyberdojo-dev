#!/usr/bin/env bash
set -e # Exit on error

cd /var/www/cyberdojo
source /usr/local/rvm/scripts/rvm
rvm use 2.1.2
bundle install
bundle exec rake db:migrate

apt-get install -y docker.io
sudo ln -s /usr/bin/docker.io /usr/bin/docker
gpasswd -a www-data docker

cd /var/www/cyberdojo/admin_scripts
ruby docker_pull_all.rb ..
