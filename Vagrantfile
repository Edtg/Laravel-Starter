# -*- mode: ruby -*-
# vi: set ft=ruby :

# Vagrantfile API/syntax version. Don't touch unless you know what you're doing!
VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  config.vm.box = "ubuntu/focal64"
  config.vm.network "public_network"
  config.vm.network :forwarded_port, guest: 80, host: 8080, auto_correct: true
  config.vm.hostname = "app"
  config.vm.synced_folder "./", "/vagrant", id: "vagrant-root",
    owner: "vagrant",
    group: "www-data",
    mount_options: ["dmode=775,fmode=775"]
  config.vm.provision :shell, :path => "vagrant/bootstrap.sh"
end
