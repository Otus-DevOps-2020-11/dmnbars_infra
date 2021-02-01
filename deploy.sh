#!/bin/bash
# install git
sudo apt-get update
sudo apt-get install -y git

# download reddit app
cd "$HOME" || exit 1
git clone -b monolith https://github.com/express42/reddit.git

# install project dependencies
cd reddit || exit 1
bundle install

# start project
puma -d
