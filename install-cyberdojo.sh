#!/usr/bin/env bash
set -e # Exit on error

cd /var/www/cyberdojo
bundle install
bundle exec rake db:migrate

cd /var/www/cyberdojo/admin_scripts
ruby docker_pull_all.rb ..
