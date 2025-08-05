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