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

# Animation
function animate_progress {
    local count=0
    while true; do
        count=$(( (count+1) %4 ))
        printf "\rPlease wait... [%s]" "${spinner[count]}"
        sleep 0.1
    done
}

# Array of spinner characters
spinner=( "⠋" "⠙" "⠹" "⠸" "⠼" "⠴" "⠦" "⠧" "⠇" "⠏" )

# Start the animation and get the PID of the animation process
animate_progress &
ANIMATE_PID=$!

# Install prerequisites
sudo apt-get update > /dev/null
sudo apt-get install -y cmake libasound2-dev libudev-dev git automake libtool texinfo g++ make > /dev/null

# Stop the animation
kill $ANIMATE_PID > /dev/null

echo ""
echo "Prerequisites installed!"

# Function to display a message with a checkmark
function show_success {
    echo -e "\xE2\x9C\x94 $1"
}

# Ask user if they want to install Hamlib
read -p "Do you want to install Hamlib? [y/n]: " INSTALL_HAMLIB

if [[ $INSTALL_HAMLIB =~ ^[Yy]$ ]]
then
    # Install Hamlib
    echo "NOTE: Hamlib can take a long time. Please give it time to complete"
    echo "Installing Hamlib..."
    git clone https://github.com/Hamlib/Hamlib > /dev/null 2>&1
    cd Hamlib
    ./bootstrap > /dev/null
    ./configure > /dev/null
    make > /dev/null
    make check > /dev/null
    sudo make install > /dev/null
    cd ..
    rm -rf Hamlib
    show_success "Hamlib installed!"
fi

# Install Direwolf
echo "Installing Direwolf..."
git clone https://www.github.com/wb2osz/direwolf > /dev/null 2>&1
cd direwolf
git checkout dev > /dev/null
mkdir build && cd build
cmake -DUNITTEST=1 .. > /dev/null
make -j4 > /dev/null
make test > /dev/null
sudo make install > /dev/null
make install-conf > /dev/null
cd ../..
rm -rf direwolf
show_success "Direwolf installed!"

echo "Installation complete! We're almost ready to get your digipeater on the air!"
