#!/bin/bash

printf "\033[31mInstalling Git... \n\033[0m"
sudo apt-get -y install git

printf "\n\033[31mCloning the codebase... \n\033[0m"
# disable strict host key checking on github.com (or else cloning will prompt for input)
printf "Host github.com\n\tStrictHostKeyChecking no\n" >> ~/.ssh/config
git clone https://github.com/northern-bites/nbites.git ~/nbites

# remove these once my Serenity branch is merged into master
git --git-dir=/home/ubuntu/nbites/.git --work-tree=/home/ubuntu/nbites remote add bjacobel https://github.com/bjacobel/nbites.git
git --git-dir=/home/ubuntu/nbites/.git --work-tree=/home/ubuntu/nbites remote update
git --git-dir=/home/ubuntu/nbites/.git --work-tree=/home/ubuntu/nbites checkout -t bjacobel/serenity
