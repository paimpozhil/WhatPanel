FROM centos

MAINTAINER paimpozhil@gmail.com

# Centos default image for some reason does not have tools like Wget/Tar/etc so lets add them
RUN yum -y install wget

RUN rpm -Uvh   http://download.fedoraproject.org/pub/epel/6/x86_64/epel-release-6-8.noarch.rpm

RUN rpm -Uvh http://pkgs.repoforge.org/rpmforge-release/rpmforge-release-0.5.3-1.el6.rf.x86_64.rpm

RUN wget -O- https://raw.github.com/Eugeny/ajenti/master/scripts/install-rhel.sh | sh

# install the Mysql / php / git / cron / duplicity / backup ninja
RUN yum -y install /sbin/service which nano openssh-server git mysql-server mysql php-mysql php-gd php-mcrypt php-zip php-xml php-iconv php-curl php-soap php-simplexml php-pdo php-dom php-cli tar \
              dbus-python.x86_64 dbus-python-devel.x86_64 dbus php-hash php-mysql vixie-cron \
              backupninja duplicity dialog

#install Ajenti the control panel
RUN yum -y install ajenti-v ajenti-v-ftp-vsftpd ajenti-v-php-fpm ajenti-v-mysql

# setup the services to start on the container bootup
RUN chkconfig mysqld on

RUN chkconfig nginx on

RUN chkconfig php-fpm on

RUN chkconfig crond on

RUN chkconfig ajenti on

## disable FTP by default ;)
RUN chkconfig vsftpd off

#allow the ssh root access.. - Diable if you dont need but for our containers we prefer SSH access.
RUN sed -i "s/UsePAM.*/UsePAM no/g" /etc/ssh/sshd_config
RUN sed -i "s/#PermitRootLogin/PermitRootLogin/g" /etc/ssh/sshd_config

RUN echo 'root:ch@ngem3' | chpasswd

RUN mkdir /scripts
ADD mysqlsetup.sh /scripts/mysqlsetup.sh
RUN chmod 0755 /scripts/*

RUN echo "/scripts/mysqlsetup.sh" >> /etc/rc.d/rc.local


ADD backup /etc/backup.d/

RUN chmod 0600 /etc/backup.* -R


EXPOSE 22 80 8000 3306 443

ENTRYPOINT ["/sbin/init"]

