Up my yoga 
# with Arch Linux

 Instructions:
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
