#!/bin/bash

cd /home/opc/logs/apache-log

if [ $# -eq 0 ]
    then
        while [ -z $request ]
        do
            read -p "No arguments supplied, try again. " request
            request=$(echo $request | awk '{ print toupper($1) }')
        done
    else
        request=$(echo $1 | awk '{ print toupper($1) }')
    fi

case $request in
    GET)
    cat apache.log | grep GET
    ;;
    
    POST)
    cat apache.log | grep POST
    ;;

    PUT)
    cat apache.log | grep PUT
    ;;

    DELETE)
    cat apache.log | grep DELETE
    ;;

    *)
    echo "Invalid"
    ;;
esac

