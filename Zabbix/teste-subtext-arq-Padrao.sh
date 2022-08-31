#!/bin/bash

##### Versão 7 ######
# fazer o lab no docker, configurar --mount no /app com o arquivo de configuração do zabbix dentro
# validar todas as etapas


#######[ Usar EOF ]#######
# cat << EOF > teste.txt
# Isert texto 
# EOF

hostname=$(echo Hostname=RenanShell)
metadata=$(echo HostMetadata=renanshell_linux)

validacao(){
    [ $? -eq 0 ] 
}

PegaVersao(){
    sub_versao=$(cat /etc/redhat-release | awk -F. '{ print $1 }')
    versao=$(echo $sub_versao | grep -o -E [0-9])
}

Execscript(){
    case $versao in 

    8) #########[ Não funcional ]#########cat 
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

    sleep 5

    yum install zabbix-agent -y

    if validacao
        then
        echo "Zabbix agent Installed"
        else
        echo "Error"
    fi

    sleep 5

    cd /app
    
    rm -rf /etc/zabbix/zabbix_agentd.conf

    cp zabbix_agentd.conf /etc/zabbix/

    if validacao 
        then
        echo "cp ok"
        else
        echo "Erro"
    fi

    sleep 5

    sed -i 's/Hostname=padrao/'$hostname'/g' /etc/zabbix/zabbix_agentd.conf

    if validacao 
        then
        echo "Hostname Ok"
        else
        echo "Erro"
    fi

    sleep 5

    sed -i 's/Hostname=padrao/'$metadata'/g' /etc/zabbix/zabbix_agentd.conf

    if validacao 
        then
        echo "Server Active IP Ok"
        else
        echo "Erro"
    fi

    sleep 5

    # service zabbix-agent restart
    systemctl enable zabbix-agent.service

    if validacao 
        then
        echo "Zabbix agent restart"
        else
        echo "Erro"
    fi

    sleep 5
    
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