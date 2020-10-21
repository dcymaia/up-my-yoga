#!/bin/bash

shopt -s extglob

usage() {
  cat <<EOF

usage: ${0##*/} "your-ESSID" "your-passphrase" "device"

$ iwconfig # for get device name 
$ iwlist device scan | grep ESSID # list ESSIDs

EOF
}


if [[ -z $1 || -z $2 || $1 = @(-h|--help) ]]; then
  usage
  exit $(( $# ? 0 : 1 ))
fi

DEVICE = 'wlp0s20f3'
if [ "$3" != "" ]; then
	DEVICE = $3
fi	

echo "Connect wifi $1 with $2 password on device ($DEVICE)"

rfkill unblock wifi

systemctl stop NetworkManager
systemctl disable NetworkManager

ifconfig $1 up
wpa_passphrase "$2" "$3" | tee /etc/wpa_supplicant.conf
wpa_supplicant -B -c /etc/wpa_supplicant.conf -i $1
ifconfig $1

exit 0
