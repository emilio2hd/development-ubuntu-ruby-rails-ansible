## development-ubuntu-ruby-rails-ansible
Ansible playbook to provision a ruby and rails deployment environment with:

* Ubuntu 14.04 (trusty32)
* Swap 512 MB
* Base Dependencies + Additional packages
* Ruby **2.2.0** (by rbevn)
* Rails **~> 4.2**
* MySQL Server + mysql2 gem

If you want change the ruby or rails version, edit [config.yml](ansible/playbook/group_vars/all/config.yml)

## Initial Instructions

Requirements:

* [Virtualbox](https://www.virtualbox.org/)
* [Vagrant >= 1.5](https://www.vagrantup.com/downloads.html)
* [Ansibl >= 1.9](https://ansible.com) when using **GNU/Linux**
* vagrant-bindfs >= 0.3.2
