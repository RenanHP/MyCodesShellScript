#!/bin/bash
# Script feito para automatizar instalação de programas no linux (Debian)

programas=()

testecat=$(cat apps.txt)

for i in $testecat
    do
    programas+=("$i")
    done

echo ${programas[@]}