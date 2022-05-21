require 'yaml'
require 'erb'

if not File.file?("config.yml")
  abort("file `config.yml` does not exist")
end
CONFIG_YML = YAML.load(ERB.new(File.read('config.yml')).result)

def check_config(host_config, required_keys)
  abort("host not defined in config.yml") if host_config.nil?
  required_keys.each do |k|
    abort("#{k} is nil") if host_config.dig(*k).nil?
  end
end

Vagrant.configure("2") do |config|
  config.vm.define 'k3s-node1' do |c|
    hostname = 'k3s-node1'
    c.vm.box = "bento/ubuntu-20.04"

    host_config = CONFIG_YML['hosts'][hostname]
    check_config(host_config, ['cpus', 'memory_mb', 'private_ip', 'ssh_forward_port'])

    c.vm.hostname = hostname
    c.vm.network "private_network", ip: host_config['private_ip']
    c.vm.network "forwarded_port", id: "ssh", guest: 22, host: host_config['ssh_forward_port']
    
    c.vm.provider "virtualbox" do |v|
      v.cpus = host_config['cpus']
      v.memory = host_config['memory_mb']
    end

    c.vm.provision "shell", path: "./provision-primary.sh"
  end

  config.vm.define 'k3s-node2' do |c|
    hostname = 'k3s-node2'
    c.vm.box = "bento/ubuntu-20.04"

    host_config = CONFIG_YML['hosts'][hostname]
    check_config(host_config, ['cpus', 'memory_mb', 'private_ip', 'ssh_forward_port'])

    c.vm.hostname = hostname
    c.vm.network "private_network", ip: host_config['private_ip']
    c.vm.network "forwarded_port", id: "ssh", guest: 22, host: host_config['ssh_forward_port']

    c.vm.provider "virtualbox" do |v|
      v.cpus = host_config['cpus']
      v.memory = host_config['memory_mb']
    end

    c.vm.provision "shell", path: "./provision-secondary.sh"
  end

  config.vm.define 'k3s-node3' do |c|
    hostname = 'k3s-node3'
    c.vm.box = "bento/ubuntu-20.04"

    host_config = CONFIG_YML['hosts'][hostname]
    check_config(host_config, ['cpus', 'memory_mb', 'private_ip', 'ssh_forward_port'])

    c.vm.hostname = hostname
    c.vm.network "private_network", ip: host_config['private_ip']
    c.vm.network "forwarded_port", id: "ssh", guest: 22, host: host_config['ssh_forward_port']

    c.vm.provider "virtualbox" do |v|
      v.cpus = host_config['cpus']
      v.memory = host_config['memory_mb']
    end

    c.vm.provision "shell", path: "./provision-secondary.sh"
  end
end
