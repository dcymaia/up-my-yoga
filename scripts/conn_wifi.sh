#!/bin/bash

shopt -s extglob

usage() {
  cat <<EOF

usage: ${0##*/} "device" "your-ESSID" "your-passphrase"

$ ifconfig # for get device name 
$ iwlist device scan | grep ESSID # list ESSIDs

EOF
}


if [[ -z $1 || -z $2 || -z $3 || $1 = @(-h|--help) ]]; then
  usage
  exit $(( $# ? 0 : 1 ))
fi

rfkill unblock wifi

systemctl stop NetworkManager
systemctl disable NetworkManager

ifconfig $1 up
wpa_passphrase $2 $3 | tee /etc/wpa_supplicant.conf
wpa_supplicant -B -c /etc/wpa_supplicant.conf -i $1
ifconfig $1

exit 0
