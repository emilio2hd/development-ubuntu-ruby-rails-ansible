# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.require_version '>= 1.5'
VAGRANTFILE_API_VERSION = '2'

def ansible_installed?
  exts = ENV['PATHEXT'] ? ENV['PATHEXT'].split(';') : ['']
  ENV['PATH'].split(File::PATH_SEPARATOR).any? do |p|
    exts.any? do |ext|
      full_path = File.join(p, "ansible-playbook#{ext}")
      File.executable?(full_path) && File.file?(full_path)
    end
  end
end

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  config.vm.provider :virtualbox do |vb|
    vb.customize ['modifyvm', :id, '--memory', '512']
  end

  config.vm.box = 'ubuntu/trusty32'

  config.vm.network 'private_network', ip: '192.168.33.101'
  config.vm.synced_folder '.', '/vagrant'
  config.vm.synced_folder 'ansible/playbook', '/ansible'

  config.vm.define 'myapplication' do |machine|
    machine.vm.network :forwarded_port, guest: 80,    host: 8080
    machine.vm.network :forwarded_port, guest: 443,   host: 8081
    machine.vm.network :forwarded_port, guest: 3000,  host: 3000, auto_correct: true  # rails application
    machine.vm.network :forwarded_port, guest: 3306,  host: 3307, auto_correct: true  # mysql
    machine.vm.network :forwarded_port, guest: 5432,  host: 5532, auto_correct: true  # postgresql
  end

  config.ssh.forward_agent = true

  if ansible_installed?
    config.vm.provision 'ansible' do |ansible|
      ansible.playbook = 'ansible/playbook/site.yml'
      ansible.sudo = true
      ansible.verbose = 'v' # To see what's going on
    end
  else
    Dir['shell/*.sh'].each do |script|
      config.vm.provision 'shell', :path => script, :privileged => false
    end
  end
end
