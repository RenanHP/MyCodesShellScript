#!/bin/bash

convert_img(){
    local caminho_imagem=$1
    local imagem_sem_extensao=$(ls $caminho_imagem | awk -F. '{ print $1 }')
    convert $imagem_sem_extensao.jpg $imagem_sem_extensao.png
}


verifica_dir()
{
    cd  $1
    for arquivo in *
    do
        local caminho_arquivo=$(find ~/Downloads/imagens-novos-livros -name $arquivo)
        if [ -d $caminho_arquivo ]
        then
            verifica_dir $caminho_arquivo
        else
            convert_img $caminho_arquivo
        fi
    done
}

verifica_dir ~/Downloads/imagens-novos-livros

if [ $? -eq 0 ]
then
    echo "Feito com sucesso!"
else
    echo "Erro!"
fi
