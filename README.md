# Vagrant-Redis-Sentinel-Consul-Cluster
Automated provisioning of Redis and Consul nodes using Vagrant. Additionally, launching Redis nodes in Sentinel cluster setup and joining consul nodes to form a Consul cluster

## Getting Started

These instructions will get you a copy of the project up and running on your local machine for development and testing purposes.

### Prerequisites

Following softwares and tools needs to be setup before proceeding with the project setup

1. **Vagrant** needs to be installed. For vagrant installation on specific machines, look below:
 - [Debian](http://www.codebind.com/linux-tutorials/install-vagrant-ubuntu-16-04/) Installation
 - [Mac OS](http://sourabhbajaj.com/mac-setup/Vagrant/README.html) Installation

2. **Ansible** installation needs to be completed before using the project. For Ansible installation on specific machines, look below:
 - [Debian](https://www.techrepublic.com/article/how-to-install-ansible-on-ubuntu/) distributions
 - [Mac OS](https://hvops.com/articles/ansible-mac-osx/) operating system
 
3. **Git** installation for cloning the project.
- [Debian](https://www.liquidweb.com/kb/install-git-ubuntu-16-04-lts/) operating systems
- Mac OS has in-built git installation. 

### Project Setup
After checking/setting up the prerequisites, we setup the project by following the steps below in the *same order*:

1. **Vagrant HostManager Plugin** needs to be installed prior to running the *Vagrantfile*. This can be setup using:
```
vagrant plugin install vagrant-hostmanager
```
2. After hostmanager plugin, *clone* the git repository using the following command in CLI:
```
git clone https://github.com/grv231/Vagrant-RedisSentinel-Consul-Clustering.git
```
3. Once the repository has been cloned and hostmanager plugin setup, change the directory to folder containing files that were cloned
```
cd ~/ Vagrant-RedisSentinel-Consul-Clustering
```
4. Now we just need to provision the servers using *Vagrantfile*. Run the command in the same directory from CLI where the Vagrantfile is present.
```
vagrant up
```
5. The vagrantfile will take time to provision, sit back and check the messages to see the status of the project cluster setup.

**Project Successful completion** should look like this:

![alt text](https://github.com/grv231/Vagrant-RedisSentinel-Consul-Clustering/blob/master/Images/SetupCompletion.png "ProjectSetupCompletion")

## Running the tests
Navigate to the folder **TestScripts** for running the tests. There are two scripts in the folder namely:

1. **RedisConsulSmokeTest.sh**
   This file is used for running smoke tests on Redis (redismaster and Slaves) and Consul Clusters. In the script, it has been              specifically written for the server *redismaster*. It can be used for running on the slaves as well, however, the server names and      commands would need to be changed accordingly.

   Make sure that you are not logged into any servers provisioned (redismaster, slaves or sentinel) before running the script. The          script needs to be run where the *Vagrantfile* is present from CLI. Run the following command:
```
vagrant ssh redismaster -c ‘/vagrant/TestScripts/RedisConsulSmokeTest.sh; /bin/bash’
```
**Test Output**
![alt text](https://github.com/grv231/Vagrant-RedisSentinel-Consul-Clustering/blob/master/Images/RedisConsulTest.png "RedisConsulSmokeTest")


2. **SentinelSmoketest.sh**
   This file is used for running smoke tests on only for checking Redis Clustering. Since the Redis Sentinel servers were put up on a      different server, we can check the Redis Cluster status from Redis Sentinels (example **redissentinel01**). Elaborate information can    be gathered from these tests using Redis Sentinels servers.

   Make sure that you are not logged into any servers provisioned (redismaster, slaves or sentinel) before running the script. The          script needs to be run where the *Vagrantfile* is present. For running the script, use the following command on the command line:
```
vagrant ssh redissentinel01 -c ‘/vagrant/TestScripts/SentinelSmoketest.sh; /bin/bash’
```
**Test Output**
![alt text](https://github.com/grv231/Vagrant-RedisSentinel-Consul-Clustering/blob/master/Images/RedisSentinelTest.png "RedisSentinelSmokeTest")

3. **Healthcheck for Redis service using Consul**
   Healthcheck information has been configured in the **consulmasterscript.sh** and **consulslavescript.sh**. This healthcheck gives the    information about Redis service running on port 6379. If the service is on, consul shows **service sync** successful.
   
   The information can be gathered by running the following command on any node (Master or Slave):
```
consul monitor
```

**Healthcheck**
![alt text](https://github.com/grv231/Vagrant-RedisSentinel-Consul-Clustering/blob/master/Images/RedisSentinelTest.png "RedisSentinelSmokeTest")

## Important Information
 - Cluster can be resized by adding/removing nodes in the *Vagrantfile* **BOXES** variable.
 - Additionally, add the master,slave,sentinel nodes in the **hosts** file for correct *Ansible* provisioning
 - Quorum can be increased/decresed for Sentinel Clusters using the file *ansible-redis/defaults/main.yml*. Values can be                  increased/decresed in this file.
```yaml
redis_sentinel_monitors:
  - name: master01
    host: localhost
    port: 6379
    quorum: 2
    auth_pass: ant1r3z
    down_after_milliseconds: 30000
    parallel_syncs: 1
    failover_timeout: 180000
    notification_script: false
    client_reconfig_script: false
```

