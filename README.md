# Instalando zabbix com Docker

## O Zabbix é um software de código aberto usado para monitorar redes, servidores, dispositivos virtuais e serviços em nuvem.
 
### A melhor abordagem para gerenciar múltiplos contêineres que precisam se comunicar, como o Zabbix e o MySQL, é usar o Docker Compose.Ele permite que você defina e execute sua aplicação multi-contêiner com um único arquivo de configuração.

## Vamos seguir os passos abaixo:
### Preparar o Banco de Dados para o Zabbix
### O Zabbix precisa de seu próprio banco de dados e de um usuário com permissões específicas. Vamos criá-los dentro do seu contêiner mysql-app existente.
------------
### Acesse o shell do MySQL dentro do seu contêiner:
````Bash
docker exec -it mysql-app mysql -uroot -p
````
-------------
### Depois crie o banco e o usuário:
SQL
### Usar os comandos que estão no arquivo SQL.sql
-----------------
### Crie um diretório para o zabbix:
````Bash
mkdir zabbix-docker
cd zabbix-docker
````
-------------
### Crie um arquivo docker-compose.yml:
````Bash
nano docker-compose.yml
````
--------------
### Cole o conteúdo:
YAML
### Salve e feche o arquivo. (Em nano, pressione Ctrl+X, depois Y e Enter).
----------------
## Iniciar os Contêineres do Zabbix
### Agora que tudo está configurado, o último passo é iniciar os contêineres do Zabbix usando o Docker Compose. No mesmo diretório onde você criou o docker-compose.yml, execute:
````Bash
docker-compose up -d
````
-------------
### Aguarde alguns minutos para que os contêineres baixem as imagens e iniciem. O primeiro início do zabbix-server pode demorar um pouco, pois ele precisa popular o banco de dados.
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

# FIM


