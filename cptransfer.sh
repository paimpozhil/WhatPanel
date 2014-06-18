#!/bin/bash

echo "Dont use work in progress"
echo "Fetching files via FTP"

cphost=$1
cpport=$2
cpuser=$3
cppass=$4



if [ "$cpport" == "" ] ;
then
cpport=22
fi

lftp  -e "set ftp:ssl-allow off;"  ftp://$cpuser:$cppass@$cphost << EOF
mirror  --use-cache /public_html /var/www
quit 0
EOF

echo  " Trying to dump mysql output via Shell"
sshpass -p '$cppass' ssh $cpuser@$cphost -p $cpport mysqldump -u$cpuser -p$cppass --all-databases > tmpsql.sql

echo "inserting data into mysql database"
mysql -hmysqldb -uadmin < tmpsql.sql

echo "removing temp file"
rm tmpsql.sql
