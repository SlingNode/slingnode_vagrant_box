# Overview

This is a simple project that we at SlingNode to pre-build Vagrant image. The resulting box has all the software dependencies installed and Docker images for all supported Ethereum clients saved locally. The Docker image versions match the current latest tag of the [slingnode.ethereum role](https://github.com/SlingNode/slingnode-ansible-ethereum/tags).

We do a lot of testing when we develop or modify our roles. We use Molecule for testing Ansible. You can read more about our testing practices [here](https://docs.slingnode.com/slingnode.ethereum/testing). 

Each test means installing all dependencies and pulling required Docker images. This adds to many gigabytes of data and takes time. Our full test suite takes around an hour to run. With the pre-packaged boc we brought it down to minutes. 


# Vagrant provider 

We use Libvirt as provider for Vagrant. The Vagrantfile has libvirt specific settings. If you wanted to build this for Virtualbox you need to comment out the following section: 

```ruby

  config.vm.provider :libvirt do |libvirt|
    libvirt.driver = "kvm"
    libvirt.graphics_type = "none"
    libvirt.cpu_mode = "host-passthrough"
    libvirt.memory = 8096
    libvirt.cpus = 3
  end

```



# Dependencies

## guestfs-tools

You need the following dependencies installed on your local machine:

```shell
sudo apt install guestfs-tools
```

## libvirt plugin

Vagrant plugins are installed in a user context. The package step needs to be executed as root and by default root does not have vagrant-libvirt plugin installed. To install it: 

```shell
sudo vagrant plugin install vagrant-libvirt 
```


# Build steps

```bash
git clone git@github.com:SlingNode/vagrant_box.git 
cd vagrant_box
./package.sh
```

NOTE: The script will prompt for sudo password during execution. This is required for vagrant package to succeed.



# Using custom box

Once the package.sh script has finished. You will have a local box available. By default the box name is: slingnode/ubuntu2204. If you wanted to change the name edit the line in the package.sh

```bash
vagrant box add --force --name slingnode/ubuntu2204 package.box
```

You can use this box like you would use any other Vagrant box. 

## SlingNode roles testing 

To use custom box with SlingNode Molecule test suite set the following environment variable:

```bash
SLINGNODE_BOX=slingnode/ubuntu2204
```

You can either export it in your shell or pass explicitly as show below

```bash
SLINGNODE_BOX=slingnode/ubuntu2204 molecule test
```

# Modifying source box

We use the "generic/ubuntu2204" source box. If you want to use a different one, edit the following variable in the Vagrantfile.

```ruby
 source_box = "generic/ubuntu2204"
 ```

# Contact

If you have any questions join our [Discord server](https://discord.gg/EPg7yfhmUU) or log a GitHub issue.

# License

MIT

# Author Information

This project was created in 2023 by [pgjavier](https://github.com/pgjavier) and [karolpivo](https://github.com/karolpivo).
