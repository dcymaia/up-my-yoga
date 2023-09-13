#!/bin/bash
#
#	


sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

sudo pacmac -S \
    discord \
    telegram-desktop \
    steam \

sudo pamac install

sudo pamac build \
    google-chrome \
    vim-plug \
