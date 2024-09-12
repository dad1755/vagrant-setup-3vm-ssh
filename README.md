# vagrant-setup-3vm-ssh
A Vagrantfile can automatically create and configure three VMs. It sets up the VMs but requires manual SSH key copying for secure access. The file defines each VM, sets up basic provisioning, and allows for manual SSH key management after VM creation.

Full vagrant script
```
Vagrant.configure("2") do |config|
  # Define server1
  config.vm.define "server1" do |server|
    server.vm.box = "ubuntu/focal64"

    server.vm.provider "virtualbox" do |vb|
      vb.memory = "1024"
      vb.cpus = 1
      server.vm.hostname = "server1"
    end

    server.vm.network "public_network", bridge: "wlp2s0"

    # Shared folder
    server.vm.synced_folder ".", "/vagrant"

    # Provisioning with shell script
    server.vm.provision "shell", path: "ssh.sh"
  end

  # Define server2
  config.vm.define "server2" do |server|
    server.vm.box = "ubuntu/focal64"

    server.vm.provider "virtualbox" do |vb|
      vb.memory = "1024"
      vb.cpus = 1
      server.vm.hostname = "server2"
    end

    server.vm.network "public_network", bridge: "wlp2s0"

    # Shared folder
    server.vm.synced_folder ".", "/vagrant"

    # Provisioning with shell script
    server.vm.provision "shell", path: "ssh.sh"
  end

  # Define server3
  config.vm.define "server3" do |server|
    server.vm.box = "ubuntu/focal64"

    server.vm.provider "virtualbox" do |vb|
      vb.memory = "1024"
      vb.cpus = 1
      server.vm.hostname = "server3"
    end

    server.vm.network "public_network", bridge: "wlp2s0"

    # Shared folder, it wil synchronize 2 folder between server and host. 
    server.vm.synced_folder ".", "/vagrant"

    # Provisioning with shell script
    server.vm.provision "shell", path: "ssh.sh"
  end
end
```
Change this to your Network Interface
```
server.vm.network "public_network", bridge: "wlp2s0"
```

This is provision script
```
#!/bin/bash

# Ensure the .ssh directory exists for the 'vagrant' user
mkdir -p /home/vagrant/.ssh

# Check if the SSH public key is available in the shared folder
if [ -f /vagrant/id_rsa.pub ]; then
    # Remove any existing public key from authorized_keys
    # This assumes you're replacing a specific key, not all keys
    sed -i '/ssh-rsa/d' /home/vagrant/.ssh/authorized_keys

    # Append the new public key to the authorized_keys file
    cat /vagrant/id_rsa.pub >> /home/vagrant/.ssh/authorized_keys

    # Set the correct ownership and permissions
    chown -R vagrant:vagrant /home/vagrant/.ssh
    chmod 700 /home/vagrant/.ssh
    chmod 600 /home/vagrant/.ssh/authorized_keys
else
    echo "SSH public key not found in /vagrant/id_rsa.pub"
fi
```


