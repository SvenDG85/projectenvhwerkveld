#!/bin/bash

# Ensure the script is run as root
if [ "$(id -u)" -ne 0 ]; then
    echo "This script must be run as root" >&2
    exit 1
fi

# Step 1: Update the system's package list
echo "Updating the package list..."
apt-get update

# Step 2: Install the software-properties-common package
echo "Installing software-properties-common..."
apt-get install -y software-properties-common

# Step 3: Add the Ansible PPA
echo "Adding the Ansible PPA..."
add-apt-repository --yes --update ppa:ansible/ansible

# Step 4: Update the package list again
echo "Updating the package list again..."
apt-get update

# Step 5: Install Ansible
echo "Installing Ansible..."
apt-get install -y ansible

# Step 6 (Optional): Configure a basic Ansible inventory
# Uncomment and modify the following lines as needed
echo "[local]" >> /etc/ansible/hosts
echo "ansiblemaster ansible_connection=local" >> /etc/ansible/hosts
echo "[all:vars]" >> /etc/ansible/hosts
echo "ansible_python_interpreter=/usr/bin/python3" >> /etc/ansible/hosts

## Step 7 Adjust Ansible.cfg
echo "[defaults]" >> /etc/ansible/ansible.cfg
echo "host_key_checking = False" >> /etc/ansible/ansible.cfg


echo "Ansible installation and basic configuration completed."
echo "Deleting the install-ansible.sh script..."
rm -- "$0"
