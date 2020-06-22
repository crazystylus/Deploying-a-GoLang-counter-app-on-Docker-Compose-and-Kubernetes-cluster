# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|

  config.vm.box = "ubuntu/xenial64"
  config.vm.network "forwarded_port", guest: 8000, host: 8000
  config.vm.provider "virtualbox" do |vb|
    vb.linked_clone = true
    vb.memory = "1024"
  end
  config.vm.synced_folder "demo-ops/", "/etc/demo-ops"
  config.vm.provision "ansible" do |ansible|
    ansible.playbook = "deploy.yaml"
  end
end
