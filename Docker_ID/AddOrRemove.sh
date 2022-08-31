#!/bin/bash

ok=0
containers=()

puxaContainers() {
    addlist=$(cat containerID.txt)
    containers+=("$addlist")
}

addtolist(){
    read -p "Digite o id do container: " container_id
    
    for i in ${containers[@]}
    do
    if [ $i == "$container_id" ]
        then
        echo "Esse container já existe no arquivo"
        exit 1
    fi
    done

    echo $container_id >> containerID.txt
    echo "Container id add com sucesso"
}

removetolist() {
    read -p "Digite o id do container: " container_id

    for i in ${containers[@]}
    do
    if [ $i == "$container_id" ]
        then
        cat containerID.txt | grep -v $container_id > containerID.tmp
        mv containerID.tmp containerID.txt
        echo "Container id removido"
        ok=1
        exit 1
    fi
    done
    if [ $ok -eq 0 ]
        then 
        echo "Esse id não existe no bd"
    fi
}

validateAdd() {
    [ $1 -eq 1 ] || [ $1 -eq 2 ]
}

Pergunta() {
    read -p $'\e[33m1) Add | 2) Remove\e[0m: ' AddOrRemove
}

puxaContainers
Pergunta

while ! validateAdd $AddOrRemove
    do
    echo "Digite 1 ou 2"
    Pergunta
done

if [ $AddOrRemove -eq 1 ]
    then
    addtolist
fi

if [ $AddOrRemove -eq 2 ]
    then
    removetolist
fi
    