# jAppModeler - Community Edition

O jAppModeler é uma ferramenta de modelagem E/R, desenvolvida em java swing. O banco de dados utilizado é o Postgresql, para gravar metadados e dados sobre o DER.
	
Todos os banco de dados que possuem drive JDBC é acessível pelo jAppModeler para importar os metadados. Já foram testados os bancos: Postgresql, mysql, mariadb, mssql Server, oracle e DB2.
	
A ferramenta possue a opção de importar os metadados do banco de dados, para modelagem visual do banco.
	

![ ](.//jappmodeler01.png  "Visualizando um DER")
	
***Pré requisitos para executar o jAppModeler.***

- Instalar o docker 
- Instalar o docker-compose 

***Para executar o jAppModeler***

Baixe o arquivo docker-compose.yaml e depois digite o comando abaixo:
        
- 	docker-compose up -f docker-compose.yaml -d
	
	