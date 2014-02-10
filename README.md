serenity
========

Continuous integration testing for the Northern Bites' robotic soccer system.

####Requirements
- Ruby == 2.0.0p247
- Bundler >= 1.5
- Vagrant >= 1.4.3
- VirtualBox >= 4.1.12
- All gems specified in the Gemfile (`bundle install`)
- RVM is reccommended


vagrant box add saucy http://cloud-images.ubuntu.com/vagrant/saucy/current/saucy-server-cloudimg-i386-vagrant-disk1.box
vagrant init saucy
vagrant up
vagrant destroy
