#!/bin/bash


CONFDIR=$HOME/up-yoga/config


ln -s $CONFDIR/.vimrc $HOME
ln -s $CONFDIR/.bashrc $HOME
ln -s $CONFDIR/.xinitrc $HOME

mkdir -p $HOME/.config/i3
ln -s $CONFDIR/i3 $HOME/.config/i3/config

mkdir -p $HOME/.config/i3status
ln -s $CONFDIR/i3status $HOME/.config/i3status/config

ln -s $CONFDIR/.Xresources $HOME

curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
