#!/bin/bash
# Autor: rhenrique & fdias
# Versão: 1.0

TOTAL_LICENSES=$(grep "Total licenses" $(find /opt/SAS*/log | sort -n | tail -1) | tail -n 1 | awk '{print $7'} | cut -d: -f2)
FREE_LICENSES=$(grep "free licenses" $(find /opt/SAS*/log | sort -n | tail -1) | tail -n 1 | awk '{print $8'} | cut -d ">" -f 2)
CONNECTED_USERS=$(expr $TOTAL_LICENSES - $FREE_LICENSES)

LicensaSas () {

echo $TOTAL_LICENSES

}

UsersConectados () {

echo $CONNECTED_USERS

}

$1
