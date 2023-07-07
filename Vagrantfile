# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|
  config.ssh.insert_key = false

  source_box = "generic/ubuntu2204"

  num_vms = 1

  config.vm.provider :libvirt do |libvirt|
    libvirt.driver = "kvm"
    libvirt.graphics_type = "none"
    libvirt.cpu_mode = "host-passthrough"
    libvirt.memory = 8096
    libvirt.cpus = 3
  end


  (1..num_vms).each do |i|
    config.vm.define "vm" do |vm|

    vm.vm.box = source_box
    vm.vm.provision  "ansible" do |ansible| 
      ansible.playbook = "build_box.yml"
    end

  end

end
end
