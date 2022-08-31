#!/bin/bash

######################################################################################
# Colocar o arquivo de configuração do zabbix e arrumar o caminho na linha           #
# Alterar o nome "Hostname" e "HostMetadata" para serem substituidos pela variavel   #
#                                                                                    #
######################################################################################


hostname=$(echo Hostname=docker_server)
metadata=$(echo HostMetadata=docker_server linux)



conf(){

    sed -i 's/Hostname=padrao/'$hostname'/g' /etc/zabbix/zabbix_agentd.conf
    if validacao
        then
        echo "Hostname Ok"
        else
        echo "Erro"
    fi

    sleep 5

    sed -i 's/HostMetadata=padrao/'"$metadata"'/g' /etc/zabbix/zabbix_agentd.conf

    if validacao 
        then
            echo "Server Active IP Ok"
        else
            echo "Erro"
    fi

    sleep 5
}

validacao(){
    [ $? -eq 0 ] 
}

PegaVersao(){
    sub_versao=$(cat /etc/redhat-release | awk -F. '{ print $1 }')
    versao=$(echo $sub_versao | grep -o -E [0-9])
}

Execscript(){
    case $versao in 

    8) #########[ Validado ]#########
    echo "Versão Oracle 8"
    echo "Add Repository"
    rpm -Uvh https://repo.zabbix.com/zabbix/5.0/rhel/8/x86_64/zabbix-release-5.0-1.el8.noarch.rpm
    dnf clean all

        if validacao 
        then
            echo "Repository add"
        else
            echo "Error"
        fi

        sleep 5

        dnf install zabbix-agent -y

        if validacao 
        then
            echo "Zabbix agent installed"
        else
            echo "Erro"
        fi

        sleep 5

        cd /home #Mudar conforme a maquina
    
        mv -f zabbix_agentd.conf /etc/zabbix/

        if validacao 
        then
            echo "zabbix_agentd.conf successfully moved"
        else   
            echo "Erro"
        fi

        sleep 5

        systemctl restart zabbix-agent

    if validacao 
        then
            echo "Zabbix agent restart"
        else
            echo "Erro"
    fi

    sleep 5

    systemctl enable --now zabbix-agent
    
    ;;

    7) #########[ Validado ]#########
    echo "versão 7"
    echo "Add Repository"

    setenforce 0

    rpm -Uvh http://repo.zabbix.com/zabbix/3.0/rhel/7/x86_64/zabbix-release-3.0-1.el7.noarch.rpm
    
    yum clean all

    if validacao 
        then
            echo "Repository add"
        else
            echo "Erro"
    fi

    sleep 5

    yum install zabbix-agent -y

    if validacao
        then
            echo "Zabbix agent installed"
        else
            echo "Error"
    fi

    sleep 5

    cd /home/renan_hpereira12

    mv -f zabbix_agentd.conf /etc/zabbix/

    if validacao 
        then
            echo "zabbix_agentd.conf successfully moved"
        else
            echo "Erro"
    fi

    sleep 5

    systemctl restart zabbix-agent

    if validacao 
        then
            echo "Zabbix restart Ok"
        else
            echo "Erro"
    fi

    systemctl enable zabbix-agent


    sed -i 's/SELINUX=enforcing/SELINUX=disabled/g' /etc/selinux/config
    
    if validacao 
        then
            echo "Selinux disabled"
        else
            echo "Erro"
    fi

    ;;

    *)
    echo "não 5,6,7 nem 8"
    ;;

esac
}

PegaVersao
Execscript
conf