# Instalando zabbix com Docker

## O Zabbix é um software de código aberto usado para monitorar redes, servidores, dispositivos virtuais e serviços em nuvem.
 
### A melhor abordagem para gerenciar múltiplos containers que precisam se comunicar, como o Zabbix e o MySQL, é usar o Docker Compose.Ele permite que você defina e execute sua aplicação multi-container com um único arquivo de configuração.

## Vamos seguir os passos abaixo:
### Preparar o Banco de Dados para o Zabbix
### O Zabbix precisa de seu próprio banco de dados e de um usuário com permissões específicas. Vamos criá-los dentro do seu container mysql-app existente.
https://github.com/willsen4/mysql-docker

------------
### Acesse o shell do MySQL dentro do seu container:
````Bash
docker exec -it mysql-app mysql -uroot -p
````

-------------
### Depois crie o banco e o usuário:
```SQL
-- Criar banco de dados Zabbix
create database zabbix_db character set utf8mb4 collate utf8mb4_bin;

-- Criar usuario do Zabbix Local
create user 'zabbix_user'@'localhost' identified by 'sua_senha_forte';
grant all privileges on zabbix_db.* to 'zabbix_user'@'localhost';
set global log_bin_trust_function_creators = 1;
flush privileges;

-- Criar usuario do Zabbix Server
create user 'zabbix_server'@'%' identified by 'sua_senha_forte';
grant all privileges on zabbix_db.* to 'zabbix_server'@'%';
set global log_bin_trust_function_creators = 1;
flush privileges;
   
-- Criar usuario do Zabbix FrontEnd
create user 'zabbix_web'@'%' identified by 'sua_senha_forte';
grant all privileges on zabbix_db.* to 'zabbix_web'@'%';
set global log_bin_trust_function_creators = 1;
flush privileges;
```

-----------------
### Crie um diretório para o zabbix:
````Bash
mkdir zabbix-docker
````
````Bash
cd zabbix-docker
````

-------------
### Crie um arquivo docker-compose.yml:
````Bash
nano docker-compose.yml
````

--------------
### Cole o conteúdo:
```YAML
services:
  zabbix-server:
    image: zabbix/zabbix-server-mysql:alpine-latest
    container_name: zabbix-server
    environment:
      DB_SERVER_HOST: mysql-app        # Nome do container MySQL
      MYSQL_DATABASE: zabbix_db        # Banco que você vai criar no MySQL
      MYSQL_USER: zabbix_server          # Usuário MySQL
      MYSQL_PASSWORD: sua_senha_segura      # Senha do usuário
    ports:
      - "10051:10051"
    networks:
      - zabbix_network
      - mysql_network
    restart: always

  zabbix-web:
    image: zabbix/zabbix-web-nginx-mysql:alpine-latest
    container_name: zabbix-web
    environment:
      DB_SERVER_HOST: mysql-app
      MYSQL_DATABASE: zabbix_db
      MYSQL_USER: zabbix_web
      MYSQL_PASSWORD: sua_senha_forte
      ZBX_SERVER_HOST: zabbix-server
      PHP_TZ: America/Sao_Paulo
    depends_on:
      - zabbix-server
    ports:
      - "8070:8080"
    networks:
      - zabbix_network
      - mysql_network
    restart: always

  zabbix-agent:
    image: zabbix/zabbix-agent:alpine-latest
    container_name: zabbix-agent
    environment:
      ZBX_SERVER_HOST: zabbix-server
    depends_on:
      - zabbix-server
    networks:
      - zabbix_network
    restart: always

networks:
  zabbix_network:
    name: zabbix_network # <--- ESTA LINHA GARANTE O NOME EXATO DA REDE
    driver: bridge
  mysql_network:
    external: true   # <-- Importante! usa a rede já existente
```
### Salve e feche o arquivo. (Em nano, pressione Ctrl+X, depois Y e Enter).

----------------
## Iniciar os Containers do Zabbix
### Agora que tudo está configurado, o último passo é iniciar os containers do Zabbix usando o Docker Compose. No mesmo diretório onde você criou o docker-compose.yml, execute:
````Bash
docker-compose up -d
````

-------------
### Aguarde alguns minutos para que os containers baixem as imagens e iniciem. O primeiro início do zabbix-server pode demorar um pouco, pois ele precisa popular o banco de dados.
### Você pode verificar os logs para ver o progresso:
````Bash
docker-compose logs -f
````

---------------
## Acessar a Interface Web do Zabbix
### Abra seu navegador e acesse: http://<IP_>:8070
### Você verá a tela de login do Zabbix. As credenciais padrão são:
* Usuário: Admin (com 'A' maiúsculo)
* Senha: zabbix

---------------
### Se o Host Zabbix Server não estiver funcionando no Dashboard do Zabbix, só editar o Host colocando o ip do Zabbix-agent na Interface.

# FIM




