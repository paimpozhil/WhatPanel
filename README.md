WhatPanel
=========

Docker based solution for easy web hosting with Ajenti supports FTP/Cron/Sql databases on Centos.

This is basically very simple control panel, if you have docker installed, you can get going with just one command :)

By default has MYSQL/PHP enabled but with Ajenti you can easily install ruby/python/nodejs or any custom softwares with simple
yum install commands
Refer : https://github.com/Eugeny/ajenti-v

##The IDEA:

* Easily & Lazily Host websites on multiple small VPS/Clouds instead of one large Dedicated server
* Dont have single point of failure
* Provide as much isolation as you can between clients 
* Allow Web w SSL/Domain aliasing/DNS/Emailing/Database in a single setup 
* Very easy to move around/scale/create dev environments

##Installation
#Install Docker on CentOS or Fedora
#To install Docker on CentOS, first enable EPEL repository, and then use yum command:

$ sudo yum install docker-io
$ sudo service docker start
$ sudo chkconfig docker on
#To install Docker on Fedora, use the following commands:

$ sudo yum install docker-io
$ sudo systemctl start docker.service
$ sudo systemctl enable docker.service
#After installing Docker on CentOS or Fedora, you need to add yourself to docker group to be able to run Docker as a non-root #user. Use this command for that:

$ sudo usermod -a -G docker $USER
#Log out, and log back in to activate the group change.

#At this point, you should be able to run docker command as a unprivileged user


##How to use?

Follow this tutorial if you like step by step instructions 
#### http://greenycloud.com/hosting-on-whatpanel/

```
## The quickest -one paste- but not so great way to test the control panel
docker run -d -p 8000:8000 -p 80:80 -p 443:443 -p 2222:22 -p 21:21 paimpozhil/whatpanel

## Best way to run control panel is with a volume attached to serve /var/lib/mysql /var/www,etc paimpozhil/data has them so 

docker run -td --name yourdataname  paimpozhil/data
docker run -d -p 8000:8000 -p 80:80 -p 443:443 -p 2222:22 -p 21:21 --volumes-from yourdataname  paimpozhil/whatpanel

```

or 

Build it yourself
```
git clone https://github.com/paimpozhil/WhatPanel.git 
cd WhatPanel
## make your changes to Dockerfile if you'd like
docker build -t whatpanel .
docker run -d -p 8000:8000 -p 80:80 -p 443:443 -p 2222:22 -p 21:21 whatpanel

## optionally build the data container (inside data directory) & use --volumes-from to seperate the data from server configuration. Learn how to use Data volumes from http://docs.docker.io/use/working_with_volumes/

```

Visit https://[ip of server]:8000 in your browser
default logins root/admin

login and go to websites section.

to access server in ssh :
default ssh port 2222
default logins root/ch@ngem3

on the docker-run command you can use different external ports than defaults for more security
ex  -p 7090:8000 , -p 2345:22  so it wont be obvious target for the attacker/viruses to try and hit your server.


##Why Centos Image ?

I would have loved to use the Ubuntu image / phusion baseimage however the ubuntu repositories are not suited for web hosting/ecommerce environments. 

Most existing websites require php 5.3.x - 5.4  but Ubuntu provides 5.5.9., Nice for new web-apps but not for existing sites.

I tried both VsFTPd/PureFTPD and both didnt work with Ajenti inside docker in Ubuntu image, and most web hosting envinroments need some sort of FTP solution atleast rarely. so I went to the Centos and everything was very smooth.

##Backups

The image comes with Backup Ninja preinstalled.. to get started ssh into your container and issue
```
ninjahelper
```
for more info please check https://labs.riseup.net/code/projects/backupninja

##What about DNS / Email?

Regarding DNS:

I would MUCH prefer to host the DNS with cheap DNS hosting that many domain providers provide like Godaddy/etc. They might charge you 1$ / year or so additional and would take away all these pains.

Or you may use a professional DNS service like Amazon Route53 and other hosted DNS solutions however they charge you like 1$/month range.

But like all the shared cPanel servers if you like to host it yourself.. see below

Ajenti already supports bind9 and email configuration out of the box. You may have to edit the bind dns zone files as a whole, this may change when Ajenti supports better GUI for bind.

Regarding EMAIL:

If all you need is outgoing emails to just work like contact forms (php mail() or just mail command in CLI) then use the following guide.

http://www.dockerforums.com/t/how-to-setup-outgoing-emails-within-centos-whatpanel-containers/75

For the Impatient.
 ```
yum install exim mailx
## install mail server & utils
chkconfig exim on
## start exim on boot
alternatives --config mta
## choose exim and you are set.
 ```

If you are looking for incoming emails to work, read below.. I will support them in the near future but with a warning.

Like DNS , Email is very critical for many business I wouldnt host my own email inside a container / VPS or even my dedicated servers that also host my web app because web apps may get hacked and will probably get blacklisted in other email spamlists.

You should go with a hosted email with exchange like 1&1 for 10$/year range or Rackspace for 2$/user/month range or 5$/user/month with Google/outlook instead of doing this for critical 

All you need to do is ssh into server , yum install bind9 / yum install ajenti-v-mail

Or add these instructions into docker file and run the image with additional ports opened .. ex: -p 53:53 (DNS) -p 25:25 (SMTP ), -p 143:143 (IMAP) -p 110:110 (POP) and so on.


##To Do 

cPanel Transfer script 


## Need support?

### http://dockerteam.com

## Credits

Ajenti: its the cPanel/Plesk killer.

#### https://github.com/Eugeny/ajenti

####  https://github.com/Eugeny/ajenti-v

Centos Project

Docker.io
