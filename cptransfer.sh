#!/bin/bash

echo "Dont use work in progress"
echo "Fetching files via FTP"

cphost=$1
cpport=$2
cpuser=$3
cppass=$4
transfertype=$5



if [ "$cpport" == "" ] ;
then
cpport=22
fi


if ["$transfertype" == ""] ;
then 

rsync -avz -e '"shpass -p '$cppass' ssh" $cpuser@$cphost:/home/$cpuser/public_html/ /var/www/ 

fi

if ["$transfertype" == "lftp"] ;
then 

lftp  -e "set ftp:ssl-allow off;"  ftp://$cpuser:$cppass@$cphost << EOF
mirror  --use-cache /public_html /var/www
quit 0
EOF

fi



echo  " Trying to dump mysql output via Shell"
sshpass -p '$cppass' ssh $cpuser@$cphost -p $cpport mysqldump -u$cpuser -p$cppass --all-databases > tmpsql.sql

echo "inserting data into mysql database"
mysql < tmpsql.sql

echo "removing temp file"
rm tmpsql.sql
