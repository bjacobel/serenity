serenity
========

Continuous integration testing for the Northern Bites' robotic soccer system.

####Requirements
- Ruby == 2.0.0p247
- Bundler >= 1.5
- Vagrant >= 1.4.3
- VirtualBox >= 4.1.12
- Postgres with role `serenity`
- All gems specified in the Gemfile (`bundle install`)


####Notes
- Manually do this to set up Vagrant until I write a generator for it. 
`$> vagrant box add precise http://files.vagrantup.com/precise32.box && vagrant init precise`
