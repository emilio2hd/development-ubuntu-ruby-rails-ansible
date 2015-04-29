# development-ubuntu-ruby-rails-ansible
Ansible playbook to provision a ruby and rails deployment environment with:

* Ubuntu 14.04 (trusty32)
* Swap 512 MB
* Base Dependencies + Additional packages (nodejs, curl)
* Ruby **2.2.0** (by rbevn)
* Rails **~> 4.2**
* SQlite 3 + sqlite3 gem
* MySQL Server + mysql2 gem
* PostgreSQL 9.3 + pg gem
* ImageMagick + rmagick gem

If you want change the ruby or rails version, edit [config.yml](ansible/playbook/group_vars/all/config.yml)

# Initial Instructions

Requirements:

* [Virtualbox](https://www.virtualbox.org/)
* [Vagrant >= 1.5](https://www.vagrantup.com/downloads.html)
* [Ansibl >= 1.9](https://ansible.com) when using **GNU/Linux**
* vagrant-bindfs >= 0.3.2

Inside your vm, the application will be founded at /vagrant.
To create a new aplicattion run de code below:

```
rails new /vagrant
```