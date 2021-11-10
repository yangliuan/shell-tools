#!/bin/bash
/usr/local/mysql/bin/mysql -uroot -p123456 -e"
create user root@'%' identified by '123456';
grant all privileges on *.* to root@'%' with grant option; 
flush privileges;"