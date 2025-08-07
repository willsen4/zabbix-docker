docker exec -it mysql-app mysql -uroot -p

-- Criar banco de dados Zabbix
create database zabbix_db character set utf8mb4 collate utf8mb4_bin;

-- Criar usuario do Zabbix Local
create user 'zabbix_user'@'localhost' identified by 'sua_senha';
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