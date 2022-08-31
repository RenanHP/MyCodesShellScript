#!/bin/bash
# Script feito para automatizar instalação de programas no linux (Debian)

user=$(whoami)

# função para instalar o Chrome
chrome(){
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
        fi
}

validateYorN(){
    [ $1 == "Y" ] || [ $1 == "N" ]
}

# Array com os programas para instalar com gerenciador de pacotes
programas=("fish" "docker.io" "sl" "htop" "vlc")
x=0
confirma=()
c=0
quantidade=${#programas[@]}



# Atualizar o sistema
read -p $'\e[33mDo you want update your System? [Y/N]\e[0m: ' update
update=$(echo $update | awk ' { print toupper($1) }')
if ! validateYorN $update
        then
            echo "Y or N, please"
            exit 1
        fi

if [ $update == "Y" ]
then
    # Update da maquina
    sudo apt update && sudo apt upgrade -y 
fi

# Pergunta se quer instalar o Google Chrome
read -p $'\e[33mDo you want install Google Chrome? [Y/N]\e[0m: ' YorN_chrome
YorN_chrome=$(echo $YorN_chrome | awk ' { print toupper($1) }')
    if ! validateYorN $YorN_chrome
        then
            echo "Y or N, please"
            exit 1
        fi

# Instalação dos programas da Array 
while [ $x -lt $quantidade ]
    do
        read -p $'\e[33mDo you want install '"${programas[x]}"$' [Y/N] \e[0m: ' YorN
        YorN=$(echo $YorN | awk ' { print toupper($1) }')
        if validateYorN $YorN 
        then    
            confirma[$c]=$YorN
            x=$((x+1))
            c=$((c+1))
        else
            echo "Y or N, please"
            exit 1
        fi
    done

# Declarando x=0 para rodar a instalação com indice 0
x=0

# Instala Google Chrome
if [ $YorN_chrome == "Y" ]
then
    chrome
fi

# Instala programas
for i in ${confirma[@]}
    do
        if [ $i == "Y" ]
        then
            sudo apt install ${programas[x]} -y
                if [ $? -eq 0 ]
                then
                    echo -e "\e[1;32m${programas[x]} success installed\e[0m"
                    x=$((x+1))
                else
                    echo "Error"
                fi
        else
            x=$((x+1))
        fi
    done
