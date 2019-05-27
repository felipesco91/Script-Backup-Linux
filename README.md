**SHELLSCRIPT CHALLENGE(NAC)**

- Formato:
	Construir um script em shell com o seguinte objetivo: Execução de backup de uma solução de webserver (Apache/HTTPD):

Logs (Do diretório default de Logs com base na FHS); Configurações: Diretório de configuração da solução dentro do /etc; DocumentRoot: Diretório responsável pelo conteúdo do servidor, código JavaScript, HTML e CSS;

**Pré-requisitos:**
 - Considere que o sistema operacional poderá ser da Família Red Hat ou Centos, seu script deverá tratar ambas as possibilidades;
 - O Backup gerado pelo script deve utilizar empacotamento com tar, zip ou rar e preferencialmente compressão de dados;
 - O script deverá gerar um backup com data, essa informação pode ser gerada no arquivo criado, diretório, etc.
 - O script deve ser persistido em GIT utilizando versionamento de código, caso o repositório seja privado autorizar o acesso para o usuário: helcorin
 - O script pode ser interativo, mas DEVE contemplar a possibilidade de execução automática (com passagem de parâmetros, por exemplo) o que permitirá o seu agendamento em Cron ou SystemD Timer;
 - Como se trata de um script automatizado é necessário prover algum tipo de LOG para auditoria de execução; A execução deve ser intuitiva ou possuir uma boa documentação, utilizar o README file do GIT com esta finalidade;
**Extras:**
 - Não é necessário que o script execute a restauração dos arquivos automaticamente mas este diferencial valerá 1 ponto extra;

 - Na documentação criar instruções sobre como agendar a execução do script usando crontab ou systemD (fica a escolha do analista qual das soluções utilizar), este item valerá 1 ponto extra;

----

1) **Introdução**

	Como solicitado, foi realizado a estruturação do script de backup para o sistema operacional UBUNTU. Sendo assim, caso teste em outro sistema o script não irá funcionar.

2) **Funcionamento**

	O Script chamado Case-Backup-NAC ira funcionar com um menu de interação com o usuario, em que tera que checar o sistema opercional, realizar a checagem da pasta de backup para copiar e salvar os arquivos do WebServer, assim que criado a pasta ele possui a opcao de gerar o backup e ja compacta-lo dentro da pasta backup. Ha tambem a opção de agendar o backup utilizando o crontab.

3) **Agendamento Crontab**

	O agendamento do Crontab sera realizado mediante interação do usuario especificando horario, data, quantidade de vezes durante a semana e quantos dias do mes sera realizado o backup. Para agendamento, o crontab funciona da seguinte forma abaixo:

	  1o. 2o. 3o. 4o. 5o. 6o.
- Exemplo: 0  4   *   *   *   who

| Campo	|    Função            |
|-------|----------------------|
|  1o.	|Minuto                |
|  2o.	|Hora                  |
|  3o.	|Dia do mês            |
|  4o.	|Mês                   |
|  5o.	|Dia da semana         |
|  6o.	|Programa para execução|

E para realizar essa função, foi criado um outro script para ser indicado no lugar do Case-Backup-NAC. O script se chama Backup-Automatico-Linux, ele sera o responsavel por realizar a atividade e gerar um log dentro da pasta backup com o usuario que o realizou, data do backup e se houve falha e sucesso.
