#!/bin/bash

convert_img(){
cd ~/Downloads/imagens-livros

if [ ! -d png ]
then 
    mkdir png
fi

for imagem in *.jpg
do
    local imgSemEx=$(ls $imagem | awk -F. '{ print $1 }')
    convert $imgSemEx.jpg png/$imgSemEx.png
done
}

convert_img>erros_conversao.txt

if [ $? -eq 0 ]
then
    echo "Feito com sucesso!"
else
    echo "Erro!"
fi
