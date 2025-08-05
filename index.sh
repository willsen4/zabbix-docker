### Acesse o shell do MySQL dentro do seu contêiner:
Bash
docker exec -it mysql-app mysql -uroot -p
### Depois crie o banco e o usuário:
SQL
CREATE DATABASE zabbix_db CHARACTER SET utf8mb4 COLLATE utf8mb4_bin;
CREATE USER 'zabbix_user'@'%' IDENTIFIED BY 'sua_senha_segura';
GRANT ALL PRIVILEGES ON zabbix_db.* TO 'zabbix_user'@'%';
FLUSH PRIVILEGES;
EXIT;
### Crie uma nova rede Docker:
Bash
docker network create zabbix_network
### Conecte seu contêiner MariaDB existente a essa nova rede:
Bash
docker network connect zabbix_network mysql-app
### Crie um diretório para o zabbix:
Bash
mkdir zabbix-docker
cd zabbix-docker
### Crie um arquivo docker-compose.yml:
Bash
nano docker-compose.yml
### Cole o conteúdo:
YAML
### Salve e feche o arquivo. (Em nano, pressione Ctrl+X, depois Y e Enter).
Bash
docker-compose up -d
### Você pode verificar os logs para ver o progresso:
Bash
docker-compose logs -f
## Acessar a Interface Web do Zabbix
### Abra seu navegador e acesse: http://<IP_>:8070
### Você verá a tela de login do Zabbix. As credenciais padrão são:
* Usuário: Admin (com 'A' maiúsculo)
* Senha: zabbix

