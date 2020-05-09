Vagrant.configure("2") do |config|
  config.vm.box = "ubuntu/bionic64"

  config.vm.network :forwarded_port, guest: 443, host: 8443

  config.vm.provision :ansible_local do |ansible|
    ansible.compatibility_mode = '2.0'
    ansible.limit = 'local'
    ansible.inventory_path = 'inventory'
    ansible.playbook = 'local.yml'
  end
end
