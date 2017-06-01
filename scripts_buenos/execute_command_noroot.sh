#!/bin/bash

# Variables
list=$1
execute=$2
timestamp=$(date "+%Y-%m-%d %H:%M:%S")
log="execute_command_noroot.log"

###AYUDA####

display_usage() {
        echo "El uso del script es: "
        echo -e "./script lista_de_hosts comando\n"
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
	
function hide() {
	stty -echo
	read -p "Clave de $USER " PWD
	stty echo
}

function create_log(){
	if [ -f ${log} ]; then
	touch $log
	fi
}

# Funcion principal
function execute_command() {
for i in $(cat $list); do echo "####$i  $timestamp####";sshpass -p $PWD ssh -t -o ConnectTimeout=5 -o StrictHostKeyChecking=no $USER@$i "$execute" ;done #| tee -a $log
}

# Entrada de la variable del usuario para la conexion ssh

reset_color 

bold

#inicio

morado

read -p "Usuario para la conexion " USER

##### SCRIPT MAIN ##########

# Oculta la contraseña del usuario de la conexión

hide

# Formato de salida de la consola, Conexion ssh y ejecucion del comando lanzado desde el teclado

reset_color

bold

verde

create_log

execute_command 

reset_color

#final
