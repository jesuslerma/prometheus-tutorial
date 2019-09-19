#!/bin/bash
sudo bash -c 'cat << EOF >> /etc/environment
LC_ALL="en_US.UTF-8"
LC_CTYPE="en_US.UTF-8"
EOF'
sudo apt-get update
wget https://github.com/prometheus/prometheus/releases/download/v2.8.0/prometheus-2.8.0.linux-amd64.tar.gz
tar -xzf prometheus-2.8.0.linux-amd64.tar.gz
rm prometheus-2.8.0.linux-amd64.tar.gz
mv prometheus-2.8.0.linux-amd64 prometheus
cd prometheus
cat << EOF > prometheus.yml
global:
  scrape_interval:     15s # Set the scrape interval to every 15 seconds. Default is every 1 minute.
  evaluation_interval: 15s # Evaluate rules every 15 seconds. The default is every 1 minute.

scrape_configs:
  - job_name: 'prometheus'
    static_configs:
    - targets: ['localhost:9090']
  - job_name: 'node_exporter'
    static_configs:
    - targets:
      - '10.6.6.2:9100'
      - '10.6.6.3:9100'
EOF
