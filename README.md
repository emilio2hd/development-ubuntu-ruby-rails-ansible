# development-ubuntu-ruby-rails-ansible
Ansible playbook to provision a ruby and rails development environment with:

* Ubuntu 14.04 (trusty32)
* Swap 512 MB
* Base Dependencies + Additional packages (nodejs and curl)
* Ruby **2.2.0** (by rbevn)
* Rails **~> 4.2**
* SQlite 3 + sqlite3 gem
* MySQL Server + mysql2 gem
* PostgreSQL 9.3 + pg gem
* ImageMagick + rmagick gem
* Vim

If you want to change the ruby or rails version, edit [config.yml](ansible/playbook/group_vars/all/config.yml)

# Initial Instructions

### Requirements:

* [Virtualbox >= 4.3](https://www.virtualbox.org/)
* [Vagrant >= 1.5](https://www.vagrantup.com/downloads.html)
* [Cygwin](https://www.cygwin.com/) if you're using **Windows**

### Port Forwards:

In Vagranfile there are some port forwards, so you can access externally mysql, postgresql and browse your application:

``` ruby
machine.vm.network :forwarded_port, guest: 3000,  host: 3000, auto_correct: true  # rails application
machine.vm.network :forwarded_port, guest: 3306,  host: 3307, auto_correct: true  # mysql
machine.vm.network :forwarded_port, guest: 5432,  host: 5532, auto_correct: true  # postgresql
```

I set ```auto_correct: true``` to change the port if the current is already in use,
so pay attention when your VM is booting, maybe you'll see some output like that:

```
==> myapplication: Clearing any previously set forwarded ports...
==> myapplication: Fixed port collision for 5432 => 5432. Now on port 2200.
...
...
myapplication: Forwarding ports...
myapplication: 80 => 8080 (adapter 1)
myapplication: 443 => 8081 (adapter 1)
myapplication: 3000 => 3000 (adapter 1)
myapplication: 3306 => 3307 (adapter 1)
myapplication: 5432 => 2200 (adapter 1) # 5432 is in use, so was changed 5432 to 2200
myapplication: 22 => 2222 (adapter 1)
```
I didn't set port forward to default ports for mysql and postgresql(3306 => 3306; 5432 => 5432), but I wrote this topic just in case someone pass for some problem.

### Creating a New Rails Project

Your application must be created at /vagrant.
Access your VM Terminal, using **ssh** and run **rails new**:

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

The **myapp** database will be created, and its gems will be installed as well.
You have to reference the gem in your Gemfile. Don't forget it!

See the configurations for all databases installed by provisioning.

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

You can access VM MySQL by some mysql client. In your client, configure:

    Host: localhost
    Port: 3307 # Check if the port didn't change, as was mentioned in Port Forwards
    User: vagrant
    Password: 123456

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

To access VM PostgreSQL by pgAdmin, configure:

    Host: localhost
    Port: 5532 # Check if the port didn't change, as was mentioned in Port Forwards
    Username: vagrant
    Password: 123456

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

* [Vagrant - ANSIBLE PROVISIONER](http://docs.vagrantup.com/v2/provisioning/ansible.html)
* [Using Vagrant for Ansible roles](http://renemoser.net/blog/2014/03/27/using-vagrant-for-ansible-roles/)
