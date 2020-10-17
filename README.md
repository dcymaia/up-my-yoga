# Up my yoga with Arch Linux

 Instructions:
   1. Boot Arch Linux flashdrive
   2. Check Internet 
   ```
    $ rfkill
    $ rfkill unblock wifi
    $ iwctl device list
    $ iwctl station wlan0 connect "WIFI"
   ```
   3. Clone this repo ```$ git clone git@github.com:dcymaia/up-my-yoga.git```
   2. Check TARGET_DISK variable
   3. Run this script
   
```
$ ./up.sh
```
