#!/bin/bash

if [ "$1" == "" ]
then
	echo "################################"
	echo "########## PING SWEEP ##########"
	echo "################################"
	echo "######## Developed by: N0KK ####"
	echo "################################"
	echo "Modo de uso: $0 REDE"
	echo "Exemplo: $0 192.168.0"

else
	echo "################################"
	echo "########## PING SWEEP ##########"
	echo "################################"
	echo "######## Developed by: N0KK ####"
	echo "################################"

for host in {1..254}; 
do
	ping -c1 $1.$host | grep "64 bytes" | cut -d " " -f 4 | sed 's/.$//';
done
fi
