#!/bin/bash

# Variables
host=$1
execute=$2
timestamp=$(date "+%Y-%m-%d %H:%M:%S")
log="execute_command_per_host.log"

###AYUDA####

display_usage() {
        echo "El uso del script es: "
        echo -e "./script \"host host1 host2 hostN\" \"comandos\"\n"
	echo
        }

# Si no se meten argumentos mostramos el uso del script 
	if [  $# -le 1 ] 
	then 
		display_usage
		exit 1
	fi 
# Ver la ayuda del script

	if [[ ( $# == "--help") ||  $# == "-h" ]] 
	then 
		display_usage
		exit 0
	fi 
###Funciones menores####

function inicio() {
	wall -n "##### SCRIPT EN EJECUCION, CUIDADO CON REINICIAR####"
		
}

function final() {
        wall -n "##### EJECUCION DEL SCRIPT TERMINADO ####"
}

function reset_color() {
	echo "$(tput sgr0)"
}

function morado() {
	echo "$(tput setaf 5)"
}

function verde() {
        echo "$(tput setaf 2)"
}

function bold() {
	echo -e "\e[1m"
}

function ssh_user(){
	read -p "Usuario para la conexion " USER
}
	
function hide() {
	stty -echo
	read -p "Clave de $USER " PWD
	stty echo
}
function hide_root() {
	echo
	stty -echo
	read -p "Patron de root: " CLAVE
	stty echo
}


# Funcion principal
function execute_command() {
for i in $host; do echo "######$i $timestamp#####"; echo $CLAVE | ./logica.sh $i ;sshpass -p $PWD ssh -t -o StrictHostKeyChecking=no -o ConnectTimeout=5 $USER@$i su --session-command=$execute ; done #| tee -a $log 
}

# Entrada de la variable del usuario para la conexion ssh

reset_color 

bold

#inicio

morado

##### SCRIPT MAIN ##########

# Oculta la contraseña del usuario de la conexión, el patron de root.

ssh_user

hide

hide_root

# Formato de salida de la consola, Conexion ssh y ejecucion del comando lanzado desde el teclado

reset_color

bold

verde

execute_command 

reset_color

#final
