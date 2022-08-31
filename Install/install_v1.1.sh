#!/bin/bash

read -p "Do you want install Fish? [Y/N] " fish
fish=$(echo $fish | awk ' { print toupper($1) }')
read -p "Do you want install Docker? [Y/N] " docker
docker=$(echo $docker | awk ' { print toupper($1) }')
read -p "Do you want install htop? [Y/N] " htop
htop=$(echo $htop | awk ' { print toupper($1) }')
read -p "Do you want install sl? [Y/N] " sl
sl=$(echo $sl | awk ' { print toupper($1) }')
read -p "Do you want install VLC? [Y/N] " vlc
vlc=$(echo $vlc | awk ' { print toupper($1) }')
read -p "Do you want install GIMP? [Y/N] " gimp
gimp=$(echo $gimp | awk ' { print toupper($1) }')
read -p "Do you want install Google Chrome? [Y/N] " chrome
chrome=$(echo $chrome | awk ' { print toupper($1) }')

# Pega nome do user
user=$(whoami)

# Update da maquina
sudo apt update && sudo apt upgrade -y 

# Instalação Fish
if [ $fish == "Y" ]
then
    sudo apt install fish -y

    if [ $? -eq 0 ]
        then
            echo -e "\e[1;32mFish success installed\e[0m"
        else
            echo "Error"
            break
    fi
fi

# Instalação docker
if [ $docker == "Y" ]
then
    sudo apt install docker.io -y

    if [ $? -eq 0 ]
        then
            echo -e "\e[1;32mDocker success installed\e[0m"
        else
            echo "Error"
            break
    fi
fi

# Terminar os if's

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

