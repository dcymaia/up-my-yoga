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
   4. Clone this repo ```$ git clone https://github.com/dcymaia/up-my-yoga.git```
   5. Check TARGET_DISK variable
   6. Run this script
   
```
$ ./up.sh
```

#### Pos Installation

* Configuring wifi with wpa_supplicant

```
$ systemctl stop NetworkManager
$ systemctl disable NetworkManager

$ rfkill
$ rfkill unblock wifi

$ iwconfig
$ ifconfig wlp0s20f3 up
$ iwlist wlp0s20f3 scan | grep ESSID
$ wpa_passphrase your-ESSID your-passphrase | tee /etc/wpa_supplicant.conf
$ wpa_supplicant -B -c /etc/wpa_supplicant.conf -i wlp0s20f3
$ ifconfig wlp0s20f3
```
