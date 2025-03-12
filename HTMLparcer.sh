#!/bin/bash

#byMusashi

RED="\e[31m"
GREEN="\e[32m"
YELLOW="\e[33m"
BLUE="\e[34m"
MAGENTA="\e[35m"
CYAN="\e[36m"
WHITE="\e[37m"
ENDCOLOR="\e[0m"

imagem="imagemnet.txt"
controle="coleta.txt"

if [ "$1" = "" ]
then
	while read linha;
        do
                echo $linha;
        done < $imagem
	echo " "
	echo -e "${BLUE}ようこそムシャシ"
	echo " "
	echo -e "無敵の？${ENDCOLOR}"
	echo " "
	echo -e "${MAGENTA}---------------------------------------------------------------${ENDCOLOR}"
	echo "SUBDOMAINS X IP for ESPECIFIC DOMAIN"
	echo " "
	echo "----> ./parceHTML.sh <domain> "
	echo " "
	echo "Não se esqueça do sudo!"

else
        while read linha;
        do
                echo $linha;
        done < $imagem
        echo " "
        echo -e "${BLUE}ようこそムシャシ"
        echo " "
        echo -e "無敵の？${ENDCOLOR}"
        echo " "



## Usando WGET para baixar HTML da página dominio e envio a arquivo index.txt
	wget --progress=bar:force $1
	sed 's/href=/\n&/g' index.html | grep 'href="' | cut -d "/"  -f3 | uniq -c | cut -d " " -f8 | cut -d '"' -f1  > coleta.txt
	cat coleta.txt | sed -i '/^$/d' coleta.txt
#Acima essa linha stripa o index até ele ficar só com os endereços e manda para um arquivo (controle.txt)
#Abaixo tem um while básico de leitura de arquivo e ele vai retornar para cada linha um comando host com a linha
	echo " "
	echo " "
	echo -e "${RED}Looking for address...${ENDCOLOR}"
	echo -e "${MAGENTA}---------------------------------------------------------------${ENDCOLOR}"
	while read Linha;
	do
		host $Linha | grep "has address" | cut -d " " -f 1,4 | sed 's/ /|   Related IP --> /g';


	done < $controle
	rm $controle
	rm "index.html"
	echo -e "${MAGENTA}---------------------------------------------------------------${ENDCOLOR}"


fi
