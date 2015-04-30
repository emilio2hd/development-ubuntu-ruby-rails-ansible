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
* Vim

If you want to change the ruby or rails version, edit [config.yml](ansible/playbook/group_vars/all/config.yml)

# Initial Instructions

Requirements:

* [Virtualbox](https://www.virtualbox.org/)
* [Vagrant >= 1.5](https://www.vagrantup.com/downloads.html)
* [Ansibl >= 1.9](https://ansible.com) when using **GNU/Linux**
* vagrant-bindfs >= 0.3.2

Inside your vm, the application will be found at /vagrant.

### Creating a New Rails Project

Access your virtual machine terminal, using **ssh** and run **rails new**:

```
vagrant ssh
rails new /vagrant
```

### Starting Rails

```
rails s -b 0.0.0.0
```
Once started, you can browse accessing http://localhost:3000

# Configuring The Database

See the configurations for all databases installed by provisioning.
The **myapp** database will be created, and its gems will be installed as well.
You have to reference the gem in your Gemfile!

### Configuring SQlite

``` yaml
development:
  adapter: sqlite3
  #database: ":memory:" # If you want database in memory (useful for test).
  database: db/development.sqlite3 # It'll be created if doesn't exist
```

### Configuring MySQL

``` yaml
development:
  adapter: mysql2
  encoding: utf8
  host: localhost
  username: vagrant
  password: 123456
  database: myapp
```

Also, you cant to access VM mysql by some mysql client. In your client, configure:
    **host**: localhost
    **port**: 3307
    **user**: vagrant
**password**: 123456

### Configuring PostgreSQL

``` yaml
development:
  adapter: postgresql
  encoding: unicode
  host: localhost
  username: vagrant
  password: 123456
  database: myapp
```

# Vagrant Commands

Start the VM:

```
$ vagrant up
```

Access the VM terminal:

```
$ vagrant ssh
```

To provision the VM again:

```
$ vagrant provision
```

Destroy the VM:

```
$ vagrant destroy
```

# More Informations & Thanks

[Vagrant - ANSIBLE PROVISIONER](http://docs.vagrantup.com/v2/provisioning/ansible.html)
[Using Vagrant for Ansible roles](http://renemoser.net/blog/2014/03/27/using-vagrant-for-ansible-roles/)