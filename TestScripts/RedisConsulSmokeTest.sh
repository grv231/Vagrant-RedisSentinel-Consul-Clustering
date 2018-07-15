#/bin/bash

# Testing the Redis cluster from Master or Slaves
echo "-----------------------------------------------------------------------------------------------"
echo "-------------------------------- Testing Redis Cluster setup ----------------------------------"
echo "-----------------------------------------------------------------------------------------------"
echo

# Testing Connectivity from Sentinel to Redis Master to slave
echo "******************* Testing Connectivity from Sentinel to Master-Slave nodes ******************"
slaveconnect1=$(sudo redis-cli -h redisslave01 ping)
slaveconnect2=$(sudo redis-cli -h redisslave02 ping)

echo
echo "Connectivity from Redis Master to Slave 01 is  $slaveconnect1"
echo "Connectivity from Redis Master to Slave 02 is  $slaveconnect2"
echo

# Checking role on master node
echo "**************************** Checking roles of master nodes ***********************************"
masterrole=$(sudo redis-cli info | grep role)
slaverole01=$(sudo redis-cli -h redisslave01 -p 6379 info | grep role)
slaverole02=$(sudo redis-cli -h redisslave02 -p 6379 info | grep role)

echo
echo "Description of Node Redismaster is:  $masterrole"
echo "Description of Node Redisslave01 is: $slaverole01"
echo "Description of Node Redisslave02 is: $slaverole02"
echo

# Testing the Consul-cluster
echo "-----------------------------------------------------------------------------------------------"
echo "----------------------------- Testing Consul Cluster setup ------------------------------------"
echo "-----------------------------------------------------------------------------------------------"
echo

# Checking members on consul cluster
echo "**************************** Checking Consul cluster Members ***********************************"
echo
echo "$(consul members)"
echo

# Checking Leader of Consul Cluster
echo "*************************** Checking Leader of Consul Cluster **********************************"
echo
echo "$(consul info | grep leader_addr)"
echo

# Checking Services configuration registered with Agent
echo "****************** Checking Services configuration registered with Agent ***********************"
echo
echo "$(consul info | grep agent -A4)"
echo

# Service setup configuration check
echo "****************** Services setup configuration check with DNS records *************************"
echo
echo "$(dig @127.0.0.1 -p 8600 redis6379.service.consul SRV +short)"
echo
