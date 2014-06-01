WhatPanel
=========

Docker based solution for easy web hosting with Ajenti !  

This is basically very simple control panel, if you have docker installed, you can get going with just one command :)

Includes support for Cron / SSH  on Centos Image

By default has MYSQL/PHP enabled but since we use Ajenti you can easily install ruby/python/nodejs or any custom softwares with simple

yum install commands


##How to use?

```

git clone https://github.com/paimpozhil/WhatPanel.git .
docker build -t whatpanel .

docker run -d -p 8000:8000 -p 80:80 -p 443:443 -p 2222:22 -p 21:21 whatpanel
```

go to http://[ip of server]:8000 in your browser
default logins root/admin

login and go to websites section.


to access server in ssh :
default ssh port 2222
default logins root/changeme


on the docker-run command you can use different external ports than defaults for more security
ex  -p 7090:8000 , -p 2345:22 

so it wont be obvious for the attacker/viruses to try and hit your server.


##Why Centos Image?

I would have loved to use the Ubuntu image / phusion baseimage however the ubuntu repositories are not suited for web hosting/ecommerce environments. 

Most existing websites require php 5.3.x - 5.4 .. but Ubuntu provides 5.5.9., Nice for newly developing websites but not for existing

I tried both VsFTPd/PureFTPD and both didnt work with Ajenti inside docker , and most web hosting envinroments need some sort of FTP solution.


##To Do 

Backup script

cPanel Transfer script 


