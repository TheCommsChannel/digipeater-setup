# TheCommsChannel Digipeater Setup Script
This script will install Direwolf and it's prereqs on to your Raspberry Pi (or equiv like Le Potato). This script is mentioned on the following YouTube https://www.youtube.com/@The_Comms_Channel

## Install
Installation is easy and can be done by simply running the command below on your device:
```
wget https://raw.githubusercontent.com/TheCommsChannel/digipeater-setup/main/tc2_direwolf.sh && chmod +x tc2_direwolf.sh && ./tc2_direwolf.sh
```

## Troubleshooting
If you chose the option of installing Hamlib, you will possibly see the following error when trying to run DireWolf `direwolf: error while loading shared libraries: libhamlib.so.4: cannot open shared object file: No such file or directory`

To resolve this issue, just run the following command:
```
echo "export LD_LIBRARY_PATH=/usr/local/lib" >> ~/.profile && source ~/.profile
```
