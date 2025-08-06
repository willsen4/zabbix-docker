CREATE DATABASE zabbix_db CHARACTER SET utf8mb4 COLLATE utf8mb4_bin;
CREATE USER 'zabbix_user'@'%' IDENTIFIED BY 'sua_senha_segura';
GRANT ALL PRIVILEGES ON zabbix_db.* TO 'zabbix_user'@'%';
FLUSH PRIVILEGES;
EXIT;

CREATE DATABASE zabbix_db CHARACTER SET utf8 COLLATE utf8_bin;
CREATE USER 'zabbix_user'@'%' IDENTIFIED BY 'sua_senha_segura';
GRANT ALL PRIVILEGES ON zabbix_db.* TO 'zabbix_user'@'%';
FLUSH PRIVILEGES;