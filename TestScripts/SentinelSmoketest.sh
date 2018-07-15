#/bin/bash
sudo apt-get update
sudo apt-get install -y redis-tools

# Testing the Redis-Sentinel cluster
echo "-----------------------------------------------------------------------------------------------"
echo "-------------------------Testing Redis Sentinel Cluster setup----------------------------------"
echo "-----------------------------------------------------------------------------------------------"
echo

#Testing Connectivity from Sentinel to Redis Master and slave
echo "******************* Testing Connectivity from Sentinel to Master-Slave nodes ******************"
masterconnect=$(sudo redis-cli -h redismaster ping)
slaveconnect1=$(sudo redis-cli -h redisslave01 ping)
slaveconnect2=$(sudo redis-cli -h redisslave02 ping)

echo
echo "Connectivity from Sentinel to Master is $masterconnect"
echo "Connectivity from Sentinel to Redis Slave 01 is $slaveconnect1"
echo "Connectivity from Sentinel to Redis Slave 02 is $slaveconnect2"
echo

# Checking appropriate roles of master and slave nodes
echo "***************************** Checking roles of master and slave nodes ************************"
masterrole=$(sudo redis-cli -h redismaster -p 6379 info | grep role)
slaverole01=$(sudo redis-cli -h redisslave01 -p 6379 info | grep role)
slaverole02=$(sudo redis-cli -h redisslave02 -p 6379 info | grep role)

echo
echo "Description of Node Redismaster is: $masterrole"
echo "Description of Node Redisslave01 is: $slaverole01"
echo "Description of Node Redisslave02 is: $slaverole02"
echo

# Testing redis-sentinel cluster master
echo "*********************** Redis Cluster Master Details from Sentinel: ***************************"
ipAddr=$(sudo redis-cli -p 26379 sentinel get-master-addr-by-name master01 | head -1)
port=$(sudo redis-cli -p 26379 sentinel get-master-addr-by-name master01 | tail -1)

echo
echo "Redis Master IP: $ipAddr"
echo "Redis Master Port: $port"
echo

# Extracting redis-sentinel cluster slave information
echo "******************** Redis Cluster Slave Information from Sentinel: ***************************"
echo
echo "Slaves IP address, port information and Master-Host: "
echo
echo "$(sudo redis-cli -p 26379 sentinel slaves master01 | grep -E 'ip|name|master-host' -A 1)"
echo
