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


vagrant box add precise http://files.vagrantup.com/precise32.box
vagrant init precise
vagrant up
vagrant destroy
