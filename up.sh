#!/bin/bash

# Instructions:
#   1. Boot Arch Linux flashdrive
#   2. Mount home partition on /mnt
#   3. Check TARGET_DISK variable
#   4. Run this script


# [!] will be erased
TARGET_DISK='/dev/nvme0n1'


BOOT_PARTITION=$TARGET_DISK'p1'
STORAGE_PARTITION=$TARGET_DISK'p2'
HOME_PARTITION=$TARGET_DISK'p3'
SWAP_PARTITION=$TARGET_DISK'p4'

HOSTNAME='morere'

if [ $(whoami) != "root" ]; then
    echo 'Must be run as root'
    exit 1
fi


function line {
    echo "---------------------------------------------------------------------"    
}

function confirm {
	echo
	echo '+-------------------------+'
	echo '| PRESS ENTER TO CONTINUE |'
	echo '+-------------------------+'
	read
}

STEPS=9


if [ "$1" == "" ]; then
	
	echo
	line
	echo '# [1/'$STEPS'] Initial config'	

	# Connection wifi
	rfkill unblock wifi
	rfkill
	iwctl device list
	iwctl station wlan0 connect "Aiuru 58"

	loadkeys br-abnt2
	timedatectl set-ntp true

	echo
	line
	echo '# [2/'$STEPS'] Formatting disk ('$TARGET_DISK')'	

	lsblk -f $TARGET_DISK
	confirm

	echo '# disk: '$BOOT_PARTITION''
	mkfs.fat -F32 $BOOT_PARTITION

	echo '# disk: '$STORAGE_PARTITION''
	mkfs.ext4 $STORAGE_PARTITION

	echo '# disk: '$HOME_PARTITION''
	mkfs.ext4 $HOME_PARTITION

	echo '# disk: '$SWAP_PARTITION''
	mkswap $SWAP_PARTITION

    echo
	line
	echo '# [3/'$STEPS'] Mounting partitions'	

	mount $STORAGE_PARTITION /mnt
	
	mkdir /mnt/boot
	mkdir /mnt/boot/efi
	mkdir /mnt/home

	mount $BOOT_PARTITION /mnt/boot/efi
	mount $HOME_PARTITION /mnt/home

	swapon $SWAP_PARTITION

	lsblk -f $TARGET_DISK
	echo '# Finished formatting disk'
	confirm

    echo
	line
	echo '# [4/'$STEPS'] Pacstrap'

	PACKAGES='base linux linux-firmware htop sudo xorg i3-wm dmenu xorg-xinit firefox xterm pulseaudio pavucontrol pcmanfm python net-tools git vlc xarchiver i3lock bash-completion openssh maim xclip numlockx base-devel make cmake gdb sdl2 xdotool patchelf ntfs-3g geany dolphin breeze-icons nfs-utils ctags evince cups the_silver_searcher gitg tig docker jdk8-openjdk jq zenity docker-compose python-mysqlclient sassc zip unzip dhcpcd gpick wget cheese aws-cli whois gnome-keyring libsecret fakeroot binutils time xsettingsd dnsutils'

	echo
	echo 'The following packages will be installed:'
	echo $PACKAGES

	confirm

	time pacstrap /mnt $PACKAGES

	confirm

	genfstab -U -p /mnt >> /mnt/etc/fstab

    echo
	line
	echo '# [5/'$STEPS'] CH Rooting'
	
	cp -r ../up-my-yoga /mnt/tmp/up-my-yoga

	arch-chroot /mnt /tmp/up-my-yoga/up.sh chroot

fi

if [ "$1" == "chroot" ]; then

    echo
	line
	echo '# [6/'$STEPS'] System configuration'

	# fonts
	pacman -S --noconfirm noto-fonts ttf-dejavu ttf-roboto ttf-inconsolata

	# links
    BIN=/usr/bin
   
	ln -s /tmp/up-my-yoga/config/10-monitor.conf /etc/X11/xorg.conf.d
	## TODO
    #ln -s /home/l31rb4g/opt/Rambox/rambox $BIN
	#ln -s /home/l31rb4g/scripts/aur $BIN
	#ln -s /home/l31rb4g/scripts/heidisql $BIN
	#ln -s /home/l31rb4g/scripts/ctrlc $BIN
	#ln -s /home/l31rb4g/scripts/vlcshare $BIN
	#ln -s /home/l31rb4g/scripts/hl $BIN
	#ln -s /home/l31rb4g/scripts/timebox $BIN
	#ln -s /home/l31rb4g/scripts/fireworks $BIN

    echo
	line
	echo '# [7/'$STEPS'] Setting timezone'
	
	# timezone, hostname
	ln -sf /usr/share/zoneinfo/America/Sao_Paulo /etc/localtime
	hwclock --systohc
	echo "en_US.UTF-8 UTF-8" >> /etc/locale.gen
	locale-gen

	echo "LANG=en_US.UTF-8" > /etc/locale.conf
	echo "KEYMAP=br-abnt2" > /etc/vconsole.conf
	echo $HOSTNAME > /etc/hostname
	echo "127.0.0.1		localhost" >> /etc/hosts
	echo "::1		    localhost" >> /etc/hosts
	echo "127.0.1.1		"$HOSTNAME".localdomain "$HOSTNAME >> /etc/hosts

    ls -la /etc/localtime

    echo
	line
	echo '# [8/'$STEPS'] Setting passwords'

	# root password
	echo -e "\n>>> Please set ROOT password"
	echo -e '1234\n1234' | passwd
    echo '>>> Password set to `1234`. Change later.'

	# Danilo password
	echo -e "\n>>> Please set danilo password"
	useradd -m danilo
	echo -e '1234\n1234' | passwd danilo
    echo '>>> Password set to `1234`. Change later.'
    echo '1234' | sudo -S -u danilo true

	# grub
    echo
	line
	echo '# [9/'$STEPS'] Installing GRUB EUFI'

	pacman -S grub-efi-x86_64 efibootmgr --noconfirm
	grub-install --target=x86_64-efi --efi-directory=/boot/efi --bootloader-id=arch_grub --recheck
	cp /usr/share/locale/en@quot/LC_MESSAGES/grub.mo /boot/grub/locale/en.mo
	grub-mkconfig -o /boot/grub/grub.cfg

  	# services
	systemctl enable dhcpcd
    systemctl enable sshd
	systemctl enable docker

	# sudo
	usermod -aG wheel danilo
	echo "%wheel ALL=(ALL) ALL" >> /etc/sudoers

    echo '1234' | sudo -S -u danilo true

	# docker
	usermod -aG docker danilo

	# vim
	old_pwd=$(pwd)
	cd /tmp
	git clone https://github.com/vim/vim.git
	cd vim

	./configure --with-features=huge \
		    --enable-multibyte \
		    --enable-rubyinterp=yes \
		    --enable-pythoninterp=yes \
		    --enable-python3interp=yes \
		    --enable-perlinterp=yes \
		    --enable-luainterp=yes \
		    --enable-gui=gtk2 \
		    --enable-cscope \
		    --with-x

	make
	sudo make install
	cd $old_pwd


	# floyd
	old_pwd=$(pwd)
	cd /tmp
	git clone https://github.com/l31rb4g/floyd.git
	cd floyd
	mkdir build
	cd build
	cmake ../src
	make
	sudo cp floyd /usr/bin
	cd $old_pwd


	# multilib
	echo "[multilib]" >> /etc/pacman.conf
	echo "Include = /etc/pacman.d/mirrorlist" >> /etc/pacman.conf
	sudo pacman -Syu --noconfirm

    # nvidia
    pacman -S nvidia nvidia-dkms nvidia-utils lib32-nvidia-utils

    # wine
    pacman -S --noconfirm wine

	# steam
	pacman -S --noconfirm steam lib32-libdrm
	sudo -u dcymaia aur https://aur.archlinux.org/steam-fonts.git

    # aur
    sudo -u dcymaia aur https://aur.archlinux.org/v4l2loopback-dkms-git.git
    sudo -u dcymaia aur https://aur.archlinux.org/spotify.git

    exit
fi


# finish
line
echo "INSTALLATION DONE! REMOVE THE INSTALLATION MEDIA."
echo "Press ENTER to reboot"
line
read

reboot
