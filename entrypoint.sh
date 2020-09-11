#!/bin/bash
chown mysql:mysql /var/run/mysqld
bash mysqld_safe --skip-grant-tables &
sleep 5

FILE=/reactome/gk_current.sql.gz
if [ ! -f "$FILE" ]; then

	if [ ! -d "/reactome" ] 
	then
	   mkdir /reactome
	fi

	wget https://reactome.org/download/current/databases/gk_current.sql.gz  -O /reactome/gk_current.sql.gz
fi

mysql -u root -e "CREATE DATABASE reactome"

gzip -dc /reactome/gk_current.sql.gz | mysql -u root --binary-mode reactome

mysql -u root -e "use mysql;update user set authentication_string=password('root') where user='root'; update user set plugin='mysql_native_password' where User='root'; flush privileges;"

java -jar reactome2gpml-converter/dist/reactome2gpml.jar localhost reactome root root 3306 /reactome Human $1