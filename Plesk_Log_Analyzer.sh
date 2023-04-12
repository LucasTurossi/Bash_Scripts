#!/bin/bash

# Define o caminho do diretório
dir_path="/var/www/vhosts"

# Obtém a lista de diretórios e salva em um arquivo txt
ls -d $dir_path/*/ > domains.txt

# Remove o caminho base e o último caractere de cada linha do arquivo
sed -i "s|$dir_path/||g; s|/$||" domains.txt

for dir in $(cat domains.txt); do
    # Executa o comando e redireciona a saída para um arquivo de texto
    cat $dir/logs/access_ssl_log | cut -d ' ' -f1 | sort | uniq -c | sort -unr | awk '{ print $1 "," $2 }' > /var/www/vhosts/"$dir"/qtdipac_ssl_"$(date +%Y%m%d_%H%M%S)"_"$dir".csv
    # Pega os 5 primeiros resultados da segunda coluna do arquivo e salva em mostips.txt
    cat /var/www/vhosts/"$dir"/qtdipac_ssl_"$(date +%Y%m%d_%H%M%S)"_"$dir".csv | awk -F',' '{print $2}' | head -n 5 > /var/www/vhosts/"$dir"/mostips.txt

    # Adiciona a linha abaixo para utilizar a variável $dir dentro do segundo loop
    dir_path="/var/www/vhosts/$dir"
    for ip in $(cat $dir_path/mostips.txt); do
        cat $dir_path/logs/access_ssl_log | grep "$ip" | cut -d '"' -f2 | uniq -c | sort -unr > $dir_path/most_accss_"$ip"_"$(date +%Y%m%d_%H%M%S)"_"$dir".csv
    done
done

# Remove o arquivo txt com a lista de diretórios
rm domains.txt