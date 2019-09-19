#!/bin/bash
sudo bash -c 'cat << EOF >> /etc/environment
LC_ALL="en_US.UTF-8"
LC_CTYPE="en_US.UTF-8"
EOF'
sudo apt-get update
wget https://github.com/prometheus/node_exporter/releases/download/v0.17.0/node_exporter-0.17.0.linux-amd64.tar.gz
tar -xzf node_exporter-0.17.0.linux-amd64.tar.gz
rm node_exporter-0.17.0.linux-amd64.tar.gz
mv node_exporter-0.17.0.linux-amd64 node_exporter
