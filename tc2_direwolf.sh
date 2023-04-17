#!/bin/bash

echo "TC² - TC² - TC² - TC² - TC² - TC² - TC² - TC² - TC² - TC² - TC² - TC² - TC² - TC² - TC² - TC²"
echo " _____ _          _____                               _____ _                            _ "
echo "|_   _| |        /  __ \                             /  __ \ |                          | |"
echo "  | | | |__   ___| /  \/ ___  _ __ ___  _ __ ___  ___| /  \/ |__   __ _ _ __  _ __   ___| |"
echo "  | | | '_ \ / _ \ |    / _ \| '_ \` _ \| '_ \` _ \/ __| |   | '_ \ / _\` | '_ \| '_ \ / _ \ |"
echo "  | | | | | |  __/ \__/\ (_) | | | | | | | | | | |\_\  \__/\ | | | (_| | | | | | | |  __/ |"
echo "  \_/ |_| |_|\___|\____/\___/|_| |_| |_|_| |_| |_|___/\____/_| |_|\__,_|_| |_|_| |_|\___|_|"
echo "TC² - TC² - TC² - TC² - TC² - TC² - TC² - TC² - TC² - TC² - TC² - TC² - TC² - TC² - TC² - TC²"
echo 
echo "This script will install Direwolf and it's prerequisites" 


# Install prerequisites
sudo apt-get update
sudo apt-get install -y cmake libasound2-dev libudev-dev git automake libtool texinfo g++ make

echo ""
echo "Prerequisites installed!"

# Function to display a message with a checkmark
function show_success {
    echo -e "\xE2\x9C\x94 $1"
}

# Ask user if they want to install Hamlib
echo -n "Do you want to install Hamlib? [y/n]: "
read -n 1 INSTALL_HAMLIB
echo ""

if [[ $INSTALL_HAMLIB =~ ^[Yy]$ ]]
then
    # Install Hamlib
    echo "Installing Hamlib..."
    git clone https://github.com/Hamlib/Hamlib
    cd Hamlib
    ./bootstrap
    ./configure
    make
    make check 
    sudo make install
    cd ..
    rm -rf Hamlib
    show_success "Hamlib installed!"
fi

# Install Direwolf
echo "Installing Direwolf..."
git clone https://www.github.com/wb2osz/direwolf
cd direwolf
git checkout dev 
mkdir build && cd build
cmake -DUNITTEST=1 .. 
make -j4 
make test 
sudo make install 
make install-conf 
cd ../..
rm -rf direwolf
show_success "Direwolf installed!"

echo "Installation complete! We're almost ready to get your digipeater on the air!"
