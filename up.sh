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
    echo "#####################################################################"
}

function confirm {
	echo
	echo '-----------------------------'
	echo ' PRESS ENTER TO CONTINUE'
	echo '-----------------------------'
	read
}

STEPS=9


if [ "$1" == "" ]; then
	
	echo
	line
	echo '# [1/'$STEPS'] Initial config'
	line

	# Connection wifi
	rfkill unblock wifi
	rfkill
	iwctl device list
	iwctl station wlan0 connect "Aiuru 58"

	loadkeys br-abnt2
	timedatectl set-ntp true
fi
