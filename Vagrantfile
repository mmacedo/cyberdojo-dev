# -*- mode: ruby -*-
# vi: set ft=ruby :

# Vagrantfile API/syntax version. Don't touch unless you know what you're doing!
VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  # Ubuntu Trusty Tahr x86_64 from https://vagrantcloud.com/ubuntu/trusty64
  config.vm.box = "ubuntu/trusty64"

  # Add memory
  config.vm.provider :virtualbox do |vb|
    vb.customize ["modifyvm", :id, "--memory", "2048"]
  end

  # Mount cyberdojo on /var/www/cyberdojo and serve it in the port 3000 of the host
  config.vm.network "forwarded_port", guest: 3000, host: 3000
  config.vm.synced_folder "./cyberdojo", "/var/www/cyberdojo", :mount_options => ["uid=33,gid=33"]

  config.vm.provision :shell, inline: "apt-get install -y git curl"
  config.vm.provision :shell, path: "install-ruby.sh"
  config.vm.provision :shell, path: "install-apache.sh"
  config.vm.provision :shell, path: "install-cyberdojo.sh"
end
