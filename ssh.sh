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
