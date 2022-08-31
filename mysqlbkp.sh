#!/bin/bash

user=$(whoiam)

caminho_home=$(/home/$user)

cd $caminho_home

if [ ! -d backup ]
then
    mkdir backup
fi

mysqldump -u root $1 > $caminho_home/backup/$1.sql

if [ $? -eq 0 ]
    then
        echo "Backup feito com sucesso!"
    else
        echo "Backup Error"
fi
