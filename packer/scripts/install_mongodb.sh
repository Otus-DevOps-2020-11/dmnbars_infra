#!/bin/bash
# add mongodb repo
wget -qO - https://www.mongodb.org/static/pgp/server-4.2.asc | apt-key add -
echo "deb [ arch=amd64,arm64 ] https://repo.mongodb.org/apt/ubuntu xenial/mongodb-org/4.2 multiverse" | tee /etc/apt/sources.list.d/mongodb-org-4.2.list

# install mongodb
apt-get update
apt-get install -y mongodb-org

# run and configure autorun for mongodb
systemctl start mongod
systemctl enable mongod
