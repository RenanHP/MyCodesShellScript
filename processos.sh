#!/bin/bash 

# 

if [ ! -d processos ]
then 
    mkdir processos
fi

processos=$(ps -e -o pid --sort -size | head -n 11 | grep [0-9])

for pid in $processos
    do
        nome_pid=$(ps -p $pid -o comm=)
        echo $nome_pid >> processos/$nome_pid.log
        echo $(date) >> processos/$nome_pid.log
        tamanho_processo=$(ps -p $pid -o size | grep [0-9])
        echo "$(bc <<< "scale=2;$tamanho_processo/1024") MB" >> processos/$nome_pid.log
    done
