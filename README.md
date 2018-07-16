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
<br>

**Project Successful completion** should look like this:
![alt text](https://github.com/grv231/Vagrant-RedisSentinel-Consul-Clustering/blob/master/Images/SetupCompletion.png "ProjectSetupCompletion")
<br>
## Running the tests
