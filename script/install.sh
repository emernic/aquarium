#!/usr/bin/env bash

echo "Updating Homebrew"
brew update
echo ""

echo "Installing rbenv"
brew install rbenv
echo ""

echo "Installing ruby-build"
brew install ruby-build
echo ""

echo "Updating .bash_profile"
eval "$(rbenv init -)"
echo ""

echo "Installing ruby"
rbenv local install
rbenv rehash
echo ""

#rbenv install -list

echo "Installing node"
brew install node
echo ""

echo "node -v: $(node -v)"
echo "npm -v: $(npm -v)"

echo "Installing bower"
npm install -g bower
echo ""

echo "Configuring config/initializers/aquarium.rb"
cp config/initializers/aquarium_template.notrb config/initializers/aquarium.rb
echo ""

echo "Configuring config/database.yml"
cp config/database_template.yml config/database.yml
echo ""

#echo 'gem "sqlite3"' >> GemFile
echo "Installing sqlite3"
gem install sqlite3
echo ""

echo "Installing sqlite3"
brew install sqlite3
echo ""

echo "Installing mysql2"
brew install mysql

xcode-select --install
gem install mysql2
echo ""

echo "Installing bundler"
gem install bundler
echo ""

echo "Installing mysql gem"
gem install mysql
echo ""

echo "Installing all gems"
bundle install
echo ""

echo "Installing all packages"
bower install
echo ""


# RAILS_ENV=development rake db:schema:load
# rake init:initialize[name,login,password,admin]
# ./restart_servers.sh
# open https://0.0.0.0:3000