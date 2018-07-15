## Vagrantfile

# -*- mode: ruby -*-
# vi: set ft=ruby :

# !! REQUIRES !! vagrant-hostmanager

# Vagrantfile API/syntax version. Don't touch unless you know what you're doing!
VAGRANTFILE_API_VERSION = '2'

# Servers for cluster setup
BOXES = [
  { name: 'redismaster', ip: '10.10.0.160', },
  { name: 'redisslave01', ip: '10.10.0.161', },
  { name: 'redisslave02', ip: '10.10.0.162', },
  { name: 'redissentinel01', ip: '10.10.0.163', },
  { name: 'redissentinel02', ip: '10.10.0.164', },
]

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  config.ssh.insert_key = false
  config.vm.box = 'ubuntu/trusty64'
  config.ssh.private_key_path = "~/.vagrant.d/insecure_private_key"
  config.ssh.forward_agent = true

  # Hostmanager config
  config.vm.provision :hostmanager
  config.hostmanager.enabled = true
  config.hostmanager.manage_host = true
  config.hostmanager.ignore_private_ip = false
  config.hostmanager.include_offline = true

  # Virtualbox config
  config.vm.provider :virtualbox do |vb|
    vb.customize ['modifyvm', :id, '--cpus', '1']
    vb.customize ['modifyvm', :id, '--memory', '1024']
    vb.customize ['modifyvm', :id, '--natdnshostresolver1', 'on']
  end

  # Creating variable for master redis-server shell provisioning for Consul
  masterip = BOXES[0].values[1]

  # Looping through the servers
  BOXES.each do |opts|
    config.vm.define opts[:name] do |config|
      config.vm.hostname = opts[:name]
      config.vm.network :private_network, ip: opts[:ip]

      # Shell Provisioning for Consul Cluster setup on master and slave servers
      if opts[:name] == 'redismaster'
        config.vm.provision "shell", path: './consulmasterscript.sh', args: "'#{opts[:name]}' '#{opts[:ip]}'"
      end
      if opts[:name] =~ %r{^redisslave.*}
        config.vm.provision "shell", path: './consulslavescript.sh', args: "'#{opts[:name]}' '#{opts[:ip]}' '#{masterip}'"
      end

      # Ansible provisioning for redis-sentinel cluster setup
      config.vm.provision "ansible" do |ansible|
        ansible.playbook = "ansible-redis.yml"
        ansible.inventory_path = "hosts"
      end
    end
  end
end
