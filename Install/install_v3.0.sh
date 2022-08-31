#!/bin/bash
# Script feito para automatizar instalação de programas no linux (Debian)

# Array com os programas para instalar com gerenciador de pacotes
programas=() 

touch apps.txt

user=$(whoami)

# função para instalar o Chrome
chrome(){
    cd /home/$user
        if [ ! -d Downloads ]
            then
                mkdir Downloads
        fi

    cd /home/$user/Downloads # baixar tmp

    wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb # validar / parametro para baixar tmp
    sudo dpkg -i google-chrome-stable_current_amd64.deb

        if [ $? -eq 0 ] # dpkg -l google
            then
                echo -e "\e[1;32mGoogle Chrome success installed\e[0m"
            else
                echo "Error"                
        fi
}

validateYorN(){
    [ $1 == "Y" ] || [ $1 == "N" ]
}

# add programas na lista de instalação
# read -p $'\e[33mDo you want add programs to install? [Y/N]\e[0m: ' add_programs
# add_programs=$(echo $add_programs | awk ' { print toupper($1) }')

# if ! validateYorN $add_programs
#    then
#        echo "Y or N, please"
#        exit 1
# fi

# if [ $add_programs == "Y" ]
#    then
#        p=1
# fi

p=1

 while [ $p -eq 1 ]
    do
        read -p $'\e[33mEnter the software\e[0m: ' software
        echo $software >> apps.txt
        read -p $'\e[33mDo you want add more softwares? [Y/N]\e[0m: ' more_apps
        more_apps=$(echo $more_apps | awk ' { print toupper($1) }')

            if ! validateYorN $more_apps
            then
                echo "Y or N, please"
                exit 1
            fi  

            if [ $more_apps == "N" ]
            then
                p=0
            fi
   done

# variaveis uteis
x=0
confirma=()
c=0
u=0
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
# while [ $x -lt $quantidade ] 
#    do
#        read -p $'\e[33mDo you want install '"${programas[x]}"$' [Y/N] \e[0m: ' YorN
#        YorN=$(echo $YorN | awk ' { print toupper($1) }')
#       if validateYorN $YorN 
#        then    
#            confirma[$c]=$YorN
#            x=$((x+1))
#            c=$((c+1))
#        else
#            echo "Y or N, please"
#            exit 1
#        fi
#    done

# Declarando x=0 para rodar a instalação com indice 0
x=0

# Instala Google Chrome
if [ $YorN_chrome == "Y" ]
then
    chrome
fi

testecat=$(cat apps.txt)

# Instala programas do pacote
for i in $testecat
    do
 #       if [ $i == "Y" ]
 #       then
            sudo apt install ${programas[x]} -y
                if [ $? -eq 0 ]
                then
                    echo -e "\e[1;32m${programas[x]} success installed\e[0m"
                    x=$((x+1))
                else
                    echo "Error"
                fi
 #       else
            x=$((x+1))
 #       fi
    done

# Instala programas do usuario
# for k in ${programas_inseridos[@]}
#    do
#    sudo apt install ${programas_inseridos[u]} -y
#    if [ $? -eq 0 ]
#                then
#                    echo -e "\e[1;32m${programas_inseridos[u]} success installed\e[0m"
#                    u=$((u+1))
#                else
#                    echo "Error"
#                    u=$((u+1))
#                fi
#    done
