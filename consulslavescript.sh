#!/bin/bash

# Using environment variables from ruby vagrantfile
nodeName=$1
ipAddr=$2
joinAddr=$3

# Install redis-cli tools for testing redis-sentinel cluster
sudo su
apt-get install -y redis-tools

# Downloading and configuring consul for Redis-master
apt-get update
apt-get install git unzip -y
cd /root
wget https://releases.hashicorp.com/consul/1.2.1/consul_1.2.1_linux_amd64.zip
unzip consul_1.2.1_linux_amd64.zip
rm -f consul_1.2.1_linux_amd64.zip
mv consul /usr/bin/
mkdir /etc/consul.d
cd /etc/consul.d

# Creating configuration file for Consul cluster setup on slaves
# Registering the redis_6379 service for healthcheck on Consul using netcat, polling on 5 seconds
# Adding the slaves to master cluster using start_join configuration
touch config.json
echo { \"datacenter\": \"test\", \"data_dir\"\: \"/tmp/consul\", \"log_level\": \"INFO\", \"node_name\": \"${nodeName}\", \"server\": true, \"bootstrap_expect\": 3, \"bind_addr\": \"${ipAddr}\", \"start_join\": [\"${joinAddr}\"], \"service\": {\"name\":\"redis6379\", \"tags\":[\"master\"], \"port\": 6379, \"check\":{\"args\":[ \"nc\", \"-zv\", \"127.0.0.1\", \"6379\" ], \"interval\": \"5s\"}}} | tee -a /etc/consul.d/config.json

# Run Agent in background mode with logging enabled on nohup.out script
cd /etc/consul.d
touch agentrun.sh
echo 'nohup consul agent -enable-script-checks=true -config-dir /etc/consul.d &' | tee -a agentrun.sh 2>&1 nohup.out

# Run the Script with sudo permissions
chmod u+x agentrun.sh
echo "-------------------------------------------------------------"
./agentrun.sh
sleep 20
