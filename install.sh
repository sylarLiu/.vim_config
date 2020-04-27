#! /usr/bin/env bash

cd ~

sudo apt-get update

# Make sure you have Python headers installed
sudo apt-get install python-dev python3-dev -y

# Install development tools and Cmake
sudo apt-get install build-essential cmake -y

# Install vundle,required
git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim_config/vim/bundle/Vundle.vim

rm -rf .vim .vimrc
ln -snf .vim_config/vim .vim
ln -snf .vim_config/vimrc .vimrc

# Install plugins with Vundle
vim +PluginInstall

# sudo pip install instant-rst
sudo apt-get install python-pip -y
sudo pip install https://github.com/Rykka/instant-rst.py/archive/master.zip
sudo apt-get install curl -y

sudo apt-get install libevent-dev -y
sudo apt-get install python-all-dev -y
sudo pip install greenlet
sudo pip install gevent
