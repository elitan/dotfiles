#!/bin/bash

exec > >(tee -i $HOME/dotfiles_install.log)
exec 2>&1
set -x

export DEBIAN_FRONTEND=noninteractive
export USERNAME=`whoami`

## update and install required packages
sudo apt-get update
sudo apt-get -y install --no-install-recommends apt-utils dialog 2>&1
sudo apt-get install -y \
  curl \
  git \
  sudo \
  wget \
  unzip \
  apt-transport-https \
  lsb-release \
  fonts-powerline \
  zsh

# Install ZSH
rm -f $HOME/.zshrc

sudo chsh -s /usr/bin/zsh
wget https://github.com/robbyrussell/oh-my-zsh/raw/master/tools/install.sh -O - | zsh
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions

# Cleanup
sudo apt-get autoremove -y
sudo apt-get autoremove -y
sudo rm -rf /var/lib/apt/lists/*

# Setup config files
ln -s $(pwd)/zshrc $HOME/.zshrc
