## Vagrant File compatible with parallels and virtualbox

Vagrant.configure("2") do |config|

  # Rabbitmq VM
  config.vm.define "pega8" do |node|
    node.vm.hostname = "pega8"
    node.vm.box = "generic/debian10"
    node.vm.box_check_update = false
##### Insert key false ###    
    node.ssh.insert_key = false
    #node.vm.synced_folder '.', '/vagrant', :disabled => true
    node.vm.network "private_network", ip: "192.168.20.20"
### Libvirt #####    
    node.vm.provider :libvirt do |domain|
      domain.memory = 8192
      domain.cpus = 2
      domain.nested = true
     # domain.storage :file, :size => '100G', :type => 'raw'
    end
### Virtualbox ####
    node.vm.provider :virtualbox do |v|
      v.name    = "pega8"
      v.memory  = 8192
      v.cpus    =  2
      # unless File.exist?('./pegadataDisk.vdi')
      #   v.customize ['createhd', '--filename', './pegadataDisk.vdi', '--size', 50 * 1024]
      # end
      #   v.customize ['storageattach', :id,  '--storagectl', 'IDE', '--port', 1, '--device', 0, '--type', 'hdd', '--medium', './pegadataDisk.vdi']
    end
    node.vm.provider :parallels do |v|
      v.memory  = 8192
      v.cpus    = 2
      #v.customize ["set", :id, "--device-add", "hdd", "--size", "51200", "--iface", "sata"]
     end
  end
end
