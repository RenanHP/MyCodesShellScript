#!/bin/bash

server=$(echo "Server=192.168.0.1")
serveractive=$(echo "ServerActive=192.168.0.1")
hostname=$(echo "Hostname=Renan Server")





validacao(){
    [ $? -eq 0 ] 
}


PegaVersao(){
    sub_versao=$(cat /etc/redhat-release | awk -F. '{ print $1 }')
    versao=$(echo $sub_versao | grep -o -E [0-9])
}

Execscript(){
    case $versao in 
    8) #########[ Não funcional ]#########
    echo "Versão 8"
    echo "Add Repository"
    dnf install https://repo.zabbix.com/zabbix/4.4/rhel/8/x86_64/zabbix-release-4.4-1.el8.noarch.rpm
       if validacao 
        then
        echo "Repository success"
        else
        echo "Erro"
        fi
    dnf install zabbix-agent
        if validacao 
        then
        echo "Zabbix agent instaled"
        else
        echo "Erro"
        fi
    systemctl enable --now zabbix-agent
    ;;

    7)
    echo "versão 7"
    echo "Add Repository"
    rpm -Uvh http://repo.zabbix.com/zabbix/3.0/rhel/7/x86_64/zabbix-release-3.0-1.el7.noarch.rpm
    if validacao 
        then
        echo "Repository sucess"
        else
        echo "Erro"
    fi
    yum install zabbix-agent -y
    if validacao
        then
        echo "Zabbix agent Installed"
        else
        echo "Error"
    fi

    sed -i 's/Server=127.0.0.1/'$server'/g' /etc/zabbix/zabbix_agentd.conf
    if validacao 
        then
        echo "Server IP Ok"
        else
        echo "Erro"
    fi
    sed -i 's/ServerActive=127.0.0.1/'$serveractive'/g' /etc/zabbix/zabbix_agentd.conf
    if validacao 
        then
        echo "Server Active IP Ok"
        else
        echo "Erro"
    fi
    sed -i 's/Hostname=Zabbix Server/'$hostname'/g' /etc/zabbix/zabbix_agentd.conf
    if validacao 
        then
        echo "Hostname Ok"
        else
        echo "Erro"
    fi
    service zabbix-agent restart
    if validacao 
        then
        echo "Zabbix agent restart"
        else
        echo "Erro"
    fi
    chkconfig zabbix-agent on
    if validacao 
        then
        echo "Zabbix agent add init"
        else
        echo "Erro"
    fi
    ;;


    6)
    echo "versão 6"
    echo "Add Repository"
    rpm -Uvh http://repo.zabbix.com/zabbix/3.0/rhel/6/x86_64/zabbix-release-3.0-1.el6.noarch.rpm
    if validacao 
        then
        echo "Repository sucess"
        else
        echo "Erro"
    fi
    yum install zabbix-agent -y
    if validacao
        then
        echo "Zabbix agent Installed"
        else
        echo "Error"
    fi
    ;;

    5) 
    echo "versão 5"
    echo "Add Repository"
    rpm -Uvh http://repo.zabbix.com/zabbix/3.0/rhel/5/x86_64/zabbix-release-3.0-1.el5.noarch.rpm
    if validacao 
        then
        echo "Repository sucess"
        else
        echo "Erro"
    fi
    yum install zabbix-agent -y
    if validacao
        then
        echo "Zabbix agent Installed"
        else
        echo "Error"
    fi
    ;;

    *)
    echo "não 5,6,7 nem 8"
    ;;

esac
}


PegaVersao
Execscript