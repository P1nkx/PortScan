#!/bin/bash

## Funcions

# Ctrl+C
function ctrl_c(){
    echo -e "\n[+] Sortint ..."
    exit 1
}
function comprovarPort(){
    (exec 3<> /dev/tcp/$1/$2) 2>/dev/null
    
    if [ $? -eq 0 ];then
        echo -e "\n[+] El port $2 [OPEN]"
    fi

    exec 3<&-
    exec 3>&-
}

# Inici
trap ctrl_c INT
declare -a ports=($(seq 1 65535))

if [ $1 ];then
    for port in ${ports[@]};do
        comprovarPort $1 $port &
    done
else
    echo -e "[!] Format incorrecte, tens que passar una ip"
fi
wait