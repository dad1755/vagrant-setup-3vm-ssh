# vagrant-setup-3vm-ssh
A Vagrantfile can automatically create and configure three VMs. It sets up the VMs but requires manual SSH key copying for secure access. The file defines each VM, sets up basic provisioning, and allows for manual SSH key management after VM creation.
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

    # Shared folder
    server.vm.synced_folder ".", "/vagrant"

    # Provisioning with shell script
    server.vm.provision "shell", path: "ssh.sh"
  end
end
```
