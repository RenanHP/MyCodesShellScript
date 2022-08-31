#!/bin/bash

cd /home/opc/logs/apache-log

read -p "1) GET | 2) POST | 3) PUT | 4) DELETE: " request


if [ $1 == "GET" ]
    then
    cat apache.log | grep $1
elif [ $1 == "POST" ]
    then
    cat apache.log | grep $1
elif [ $1 == "PUT" ]
    then
    cat apache.log | grep $1
elif [ $1 == "DELETE" ]
    then
    cat apache.log | grep $1
else
    echo "Isso não é uma requisição."
fi 
