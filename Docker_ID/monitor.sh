#!/bin/bash


puxaContainersTXT() {
    addtxt=$(cat containerID.txt)
    containerstxt+=("$addtxt")
}

puxaContainersDOCKER() {
    adddocker=$(docker ps --format "{{.ID}}")
    containersdocker+=("$adddocker")
    echo ${containersdocker[@]} > docker.tmp
}

Monitora(){
    for i in ${containerstxt[@]}
    do
        pesquisa=$(grep -o $i docker.tmp)
        if [ "$pesquisa" != "$i" ]
        then
            echo "$i caius"
            docker start $i
        fi
    done
}

puxaContainersTXT
puxaContainersDOCKER

Monitora
