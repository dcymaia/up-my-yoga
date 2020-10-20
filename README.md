Up my yoga 
# with Arch Linux

#### Instructions:

   1. Boot Arch Linux flashdrive
   2. Check Internet 
   ```
    $ rfkill
    $ rfkill unblock wifi
    $ iwctl device list
    $ iwctl station wlan0 connect "WIFI"
   ```
   3. Install git ```$ pacman -Sy git``` 
   4. Clone this repo ```$ git clone https://github.com/dcymaia/up-yoga.git```
   5. Check TARGET_DISK variable
   6. Run this script
   
```
$ ./arch-install.sh
```

#### Pos Installation

Connect to a wireless network

> Check wifi is unblocked

```
# rfkill
# rfkill unblock wifi
```

* Using command line nmcli
```
# systemctl enable NetworkManager
# systemctl start NetworkManager

# nmcli device wifi rescan
# nmcli device wifi list
# nmcli device wifi connect SSID-Name password wireless-password
```

> or

* Configuring with wpa_supplicant
```
# systemctl stop NetworkManager
# systemctl disable NetworkManager

# iwconfig
# ifconfig wlp0s20f3 up
# iwlist wlp0s20f3 scan | grep ESSID
# wpa_passphrase your-ESSID your-passphrase | tee /etc/wpa_supplicant.conf
# wpa_supplicant -B -c /etc/wpa_supplicant.conf -i wlp0s20f3
# ifconfig wlp0s20f3
```
