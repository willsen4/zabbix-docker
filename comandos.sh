#Acesse o Shell do conteiner
Bash
docker exec -it zabbix-app bash

#Remove o arquivo
Bash
rm install/install.php

#Acessa a pasta
cd zabbix-docker

#Logs
docker logs zabbix-app

#Remover o conteiner
docker compose down

#Altera o arquivo de configuração
nano docker-compose.yml

#Recria o conteiner
docker compose up -d

------------------
 
#Comandos no shell do MySQL:
#Acesse o Shell do conteiner
Bash
docker exec -it mysql-app bash

#Acesse o Cliente do container MySQL
docker exec -it mysql-app mysql -uroot -p

#Lista os usuários criados no MySQL (localhost são usuários com permissão local / % são usuários permissões remotas)
SELECT user, host FROM mysql.user;

#Alterar senha
SQL
ALTER USER 'seu_user'@'%' IDENTIFIED BY 'SUA_NOVA_SENHA_FORTE';
ALTER USER 'seu_user'@'localhost' IDENTIFIED BY 'SUA_NOVA_SENHA_FORTE';
FLUSH PRIVILEGES;
EXIT;

DROP DATABASE nome_do_banco;