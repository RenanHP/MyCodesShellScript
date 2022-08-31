#!/bin/bash

# Pega nome do user
user=$(whoami)

# Update da maquina
sudo apt update && sudo apt upgrade -y 

# Instalação Fish
sudo apt install fish -y

if [ $? -eq 0 ]
    then
        echo -e "\e[1;32mFish success installed\e[0m"
    else
        echo "Error"
        break
fi

# Instalação docker
sudo apt install docker.io -y

if [ $? -eq 0 ]
    then
        echo -e "\e[1;32mDocker success installed\e[0m"
    else
        echo "Error"
        break
fi

# Instalação htop
sudo apt install htop -y

if [ $? -eq 0 ]
    then
        echo -e "\e[1;32mhtop success installed\e[0m"
    else
        echo "Error"
        break
fi

# Instalação sl
sudo apt install sl -y

if [ $? -eq 0 ]
    then
        echo -e "\e[1;32msl success installed\e[0m"
    else
        echo "Error"
        break
fi

# Instalação VLC
sudo apt install vlc -y

if [ $? -eq 0 ]
    then
        echo -e "\e[1;32mVLC success installed\e[0m"
    else
        echo "Error"
        break
fi

# Instalação GIMP
sudo apt install gimp -y

if [ $? -eq 0 ]
    then
        echo -e "\e[1;32mGIMP success installed\e[0m"
    else
        echo "Error"
        break
fi

# Instalação Google Chrome
cd /home/$user

if [ ! -d Downloads ]
    then
        mkdir Downloads
fi

cd /home/$user/Downloads

wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
sudo dpkg -i google-chrome-stable_current_amd64.deb

if [ $? -eq 0 ]
    then
        echo -e "\e[1;32mGoogle Chrome success installed\e[0m"
    else
        echo "Error"
        break
fi

