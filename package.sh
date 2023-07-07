#!/bin/bash
# Install latest version of the role 
ansible-galaxy role install --force slingnode.ethereum
# Update base box
vagrant box update
# Remove existing package
rm -f package.box
vagrant up --provision
# This must be run with sudo otherwise it fails with permission error
printf "\n\n\n ---------- Please enter sudo password to begin packaging ---------- \n\n\n"
sudo vagrant package
sudo chown $USER:$USER package.box 
vagrant box add --force --name slingnode/ubuntu2204 package.box