#!/usr/bin/env bash
set -e # Exit on error

curl -sSL https://get.rvm.io | bash -s stable

source /usr/local/rvm/scripts/rvm
rvm use --install 2.1.2 --default
shift

gem update --system
gem install bundler
