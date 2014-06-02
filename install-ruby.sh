#!/usr/bin/env bash
set -e # Exit on error

# Packages for ruby-build (https://github.com/sstephenson/ruby-build/wiki#suggested-build-environment)
apt-get install -y autoconf bison build-essential libssl-dev libyaml-dev libreadline6 libreadline6-dev zlib1g zlib1g-dev

# Install rbenv
git clone https://github.com/sstephenson/rbenv ~/.rbenv
echo 'export PATH="$HOME/.rbenv/bin:$PATH"' >> ~/.bash_profile
echo 'eval "$(rbenv init -)"' >> ~/.bash_profile
source ~/.bash_profile
git clone https://github.com/sstephenson/ruby-build ~/.rbenv/plugins/ruby-build
git clone https://github.com/sstephenson/rbenv-gem-rehash ~/.rbenv/plugins/rbenv-gem-rehash
echo 'gem: --no-rdoc --no-ri' >> ~/.gemrc

RUBY_CONFIGURE_OPTS=--with-readline-dir="/usr/lib/libreadline.so" rbenv install 2.1.2
rbenv rehash
rbenv global 2.1.2
gem update --system
gem install bundler
