# Initial Install #

Here are the steps / things that need to be done to do the initial install and setup of the Ubuntu Mate OS on the Raspberry Pi 3B+ boards to be used for Spring 2019 AA241x class.

The main steps required:

 1. Setup Ubuntu Mate 18.04
     - flash the OS to the SD card
     - insert card, power up Raspberry Pi, and run through initial configuration
         + NOTE: set the user to `aa241x` with password `aa241x`

 2. Enable Raspberry PiCam
     - run `sudo raspi-config`
     - select `Interfacing Options` and select `P1 Camera`
     - select no on the restart

 3. Connect to Internet
     - Connect to `Stanford Visitor`
         + alternative -> connect to `Stanford` and register the device
     - Open Firefox and accept the Stanford terms to get internet access

 4. Run Install Script
     - clone it from online (need to install git with `sudo apt-get install git` and then clone with `git clone https://github.com/aa241x/scripts.git`)
     - navigate into the directory (`cd scripts`)
     - make script runnable (`sudo chmod +x install_everything.sh`)
     - run script (e.g. `./install_everything.sh`)
     - type sudo password when prompted
 
 5. Configure Internet
     - edit the wired connection as follows:
         + create a new connection for ethernet called `local-wired`
         + configure the IPv4 address to manual with:
             * ip: `192.168.1.41`
             * subnet mask: `255.255.255.0`
         + in the general settings make sure that automatically connect is checked
         + go to the original wired connection (should be called `wired connection `)
             * in the general settings uncheck the automatically connect option