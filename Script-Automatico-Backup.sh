#!/bin/bash
#
#Pastas de Origem do Apache 2
DIRORI=("/var/log/apache2" "/var/www")
#Copiar arquivos
DIRARQ=("/etc/apache2/apache2.conf" "/etc/apache2/conf-available" "/etc/apache2/conf-enabled")
#Array para trazer os arquivos e logs
CAMINHOS=(${DIRORI[@]} ${DIRARQ[@]})
#Pasta destino para salvar arquivo de backup
DIRDEST="/backup"
#Data e Hora para ser inserido no backup
DATA=$(date '+%d-%m-%y-%Hh%Mmin')
#Nomeação do backup
BKPNome="backup-$DATA.tar.gz"
#criar pasta backup
sudo mkdir /backup
#Para compactar diretorio salvo
sudo tar -czvf $DIRDEST/$BKPNome ${CAMINHOS[@]}
if [ $? -eq 0 ] ; then
 	echo "-----------------------------------"
 	echo "Backup concluido!"
 	touch /backup/log-backup-$DATA.txt
 	echo "Backup realizado com sucesso!" > /backup/log-backup-$DATA.txt
 	echo "Criado pelo usuário: $USER" > /backup/log-backup-$DATA.txt
 	echo "Feito o backup na data: $DATA" > /backup/log-backup-$DATA.txt
 	echo " "
 	echo "Log gerado no arquivo log-backup-$DATA.txt"
else
 	echo"ERRO! Backup não realizado!"
fi
