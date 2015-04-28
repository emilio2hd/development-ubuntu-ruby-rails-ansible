# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.require_version '>= 1.5'
VAGRANTFILE_API_VERSION = '2'

def require_plugins(plugins = {})
  needs_restart = false

  plugins.each do |plugin, version|
    next if Vagrant.has_plugin?(plugin)
    cmd = ['vagrant plugin install', plugin]
    cmd << "--plugin-version #{version}" if version
    system(cmd.join(' ')) || exit!
    needs_restart = true
  end

  exit system('vagrant', *ARGV) if needs_restart
end

require_plugins \
  'vagrant-bindfs' => '0.3.2'

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
    machine.vm.network 'forwarded_port', :guest => 80, :host => 8080, :auto_correct => true
    machine.vm.network 'forwarded_port', :guest => 443, :host => 8081, :auto_correct => true
  end

  config.ssh.forward_agent = true

  if ansible_installed?
    config.vm.provision 'ansible' do |ansible|
      ansible.playbook = 'ansible/playbook/site.yml'
      ansible.sudo = true
    end
  else
    Dir['shell/*.sh'].each do |script|
      config.vm.provision 'shell', :path => script, :privileged => false
    end
  end
end
