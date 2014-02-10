#!/bin/bash

printf "\033[31mInstalling Git... \n\033[0m"
sudo apt-get -y install git

printf "\n\033[31mCloning the codebase... \n\033[0m"
# disable strict host key checking on github.com (or else cloning will prompt for input)
printf "Host github.com\n\tStrictHostKeyChecking no\n" >> ~/.ssh/config
git clone https://github.com/northern-bites/nbites.git ~/nbites

# remove these once my PR is pulled
git --git-dir=/home/vagrant/nbites/.git --work-tree=/home/vagrant/nbites remote add bjacobel https://github.com/bjacobel/nbites.git
git --git-dir=/home/vagrant/nbites/.git --work-tree=/home/vagrant/nbites remote update
git --git-dir=/home/vagrant/nbites/.git --work-tree=/home/vagrant/nbites checkout -t bjacobel/ubuntu13.10

printf "\n\033[31mRunning linux_setup.sh... \n\033[0m"
#~/nbites/util/scripts/linux_setup.sh 1.14.3