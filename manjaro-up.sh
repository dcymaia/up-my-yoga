#!/bin/bash
#
#	

sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

sudo pacmac -S \
    discord \
    telegram-desktop \
    steam \
    docker \
    docker-compose \
    the_silver_searcher \
    sublime-text \


sudo pamac install
    spotify-launcher \
    downgrade \
    ipython \

sudo pamac build \
    google-chrome \
    vim-plug \
    postman \
    google-earth \
    stremio \

# Docker
sudo systemctl start docker.service
sudo systemctl enable docker.service
sudo usermod -aG docker $USER

# Dark theme for Gnome Terminal
git clone https://github.com/dracula/gnome-terminal
cd gnome-terminal
./install.sh


