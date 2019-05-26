#!/bin/bash
#
#Programa para Realizar Backup em Ubuntu
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
#Controle da função principal
control=0
#
clear
#
#Script Principal
principal(){
	if [ $control -eq 0 ]; then
		echo "Script para realizar Backup do Banco de Dados Apache2 em Ubuntu"
		echo " "
		echo "Siga os passos abaixo."
		echo "Digite 1 para verificar pasta backup"
		echo "Digite 2 para verificar sistema"
		echo "Digite 3 para realizar backup"
		echo "Digite 4 para agendar backup"
		echo "Digite 5 para Sair"
		echo "Opção: "
		read opcao
	elif [ $control -eq 1 ]; then
		echo "OPÇÃO INCORRETA FAVOR SELECIONAR A OPÇÃO NA ORDEM ABAIXO"
		echo " "
		echo "Digite 1 para verificar pasta backup"
		echo "Digite 2 para verificar sistema"
		echo "Digite 3 para realizar backup"
		echo "Digite 4 para agendar backup"
		echo "Digite 5 para Sair"
		echo "Opção: "
		read opcao	
	else 
		echo "Backup realizado com sucesso!"
		echo " "
		echo "Log inserido dentro da pasta /backup/ dentro da pasta home"
	fi
	case $opcao in
	1)verificacarpasta; principal ;;
	2)verificarsistema; principal ;;
	3)realizarbackup; principal ;;
	4)agendamentobackup; principal ;;
	5)echo "Saindo..."; exit ;;
	*)echo "Opção Desconhecida"; principal ;;
	esac
}
verificarsistema(){
	test -f /etc/lsb-release
	if [ $? != 0 ]; then
		echo "Sistema operacional incorreto"
		echo "Favor utilizar em um SO Válido!(Ubuntu)"
		sleep 1
		return principal
	else
		echo "Sistema Operacional é válido"
		return principal
	fi
}
realizarbackup(){
	tar -czvf $DIRDEST/$BKPNome ${CAMINHOS[@]}
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
}
#Verificação pasta Backup
verificacarpasta(){
	if [ -e "/backup" ]; then
		echo "Diretorio existe!"
		echo
	else
		echo "Diretorio não criado!"
		echo "Criando diretorio..."
		mkdir /backup
	fi
}
agendamentobackup(){
#Funcao para automatizar o Script de backup
	echo " "
    	echo "Agendamento para backup do Apache2, LER README ANTES DE AGENDAR!"
	echo " "
	read -p "Digite a hora (0 a 23): " HORA
    	read -p "Digite a minuto - 0 a 59: " MINUTO
    	read -p "Digite a Dia do Mês - 1 a 31: " DIA
    	read -p "Digite a Mês - 1 a 12: " MES
    	read -p "Digite a Dia da Semana - 0 a 6 (0 é Domingo): " SEMANA
    	read -p "Digite a Caminho do Script de Backup Automatico: " DIRETORIO
    	echo " "
	echo "$MINUTO $HORA $DIA $MES $SEMANA $DIRETORIO" >> /var/spool/cron/crontabs/root
}
principal

