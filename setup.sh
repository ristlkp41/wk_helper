#!/bin/bash

cat <<EoT
#
# Paketliste aktualisieren und Abhängigkeiten nachinstallieren
#
EoT
sudo apt-get update

sudo apt-get install autoconf bison build-essential libssl-dev libyaml-dev libreadline6-dev zlib1g-dev libncurses5-dev libffi-dev libgdbm3 libgdbm-dev git libsqlite3-dev nodejs


cat <<EoT
#
# Ruby Umgebung einrichten
#
EoT
git clone https://github.com/rbenv/rbenv.git ~/.rbenv
echo 'export PATH="$HOME/.rbenv/bin:$PATH"' >> ~/.bashrc
echo 'eval "$(rbenv init -)"' >> ~/.bashrc

git clone https://github.com/rbenv/ruby-build.git ~/.rbenv/plugins/ruby-build

~/.rbenv/bin/rbenv install 2.4.1
~/.rbenv/bin/rbenv global 2.4.1


gem install bundler

cat <<EoT
#
# Applikation einrichten
#
EoT
git clone https://github.com/ristlkp41/wk_helper ~/wk_helper
cd ~/wk_helper

echo "production:" >> config/secrets.yml
echo "  secret_key_base: $(bundle exec rake secret)" >> config/secrets.yml

sed -i "s/config.assets.compile = false/config.assets.compile = true/" config/environments/production.rb

bundle install

RAILS_ENV=production bundle exec rake db:create
RAILS_ENV=production bundle exec rake db:schema:load
RAILS_ENV=production bundle exec rake db:seed
RAILS_ENV=production bundle exec rake assets:precompile
