# -*- mode: ruby -*-
# vi: set ft=ruby :

ENV['VAGRANT_DEFAULT_PROVIDER'] = 'libvirt'

# Check required plugins
REQUIRED_PLUGINS_LIBVIRT = %w(vagrant-libvirt)
exit unless REQUIRED_PLUGINS_LIBVIRT.all? do |plugin|
  Vagrant.has_plugin?(plugin) || (
    puts "The #{plugin} plugin is required. Please install it with:"
    puts "$ vagrant plugin install #{plugin}"
    false
  )
end

Vagrant.configure("2") do |config|

  # Rabbitmq VM
  config.vm.define "pega8" do |node|
    node.vm.hostname = "pega8"
    node.vm.box = "debian/buster64"
    node.vm.box_check_update = false
##### Insert key false ###    
    node.ssh.insert_key = false
    #node.vm.synced_folder '.', '/vagrant', :disabled => true
    node.vm.network "private_network", ip: "192.168.20.20"
    node.vm.provider :libvirt do |domain|
      domain.memory = 8124
      domain.cpus = 2
      domain.nested = true
      domain.storage :file, :size => '100G', :type => 'raw'
    end
  end
end
