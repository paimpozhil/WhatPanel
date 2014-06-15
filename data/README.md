### This is the Standard Data container for WhatPanel

It provides the following volumes which can be used from the other Containers. 
* /data 
* /backup 
* /var/lib/mysql 
* /var/www 

Our other standard containers like 
Apache/Nginx/etc will use these volumes to persist their data. You can 
add more volumes in Dockerfile if you wish to OR you can just use the 
subdirectories under /data for postgres/etc.

#### Quick way

```
docker run -td --name [yourdataname] paimpozhil/data

##Now you have the volumes setup , run another container to utlize this

docker run -ti --name whatever --volumes-from [yourdataname] [imagename] /your/command

```

#### How to build & run with your modifications.
```
docker build -t stddata .
```

#### How to start a data volume
```
docker run -td --name [yourdataname] stddata
```

#### How to use in other containers
docker run -ti --name whatever --volumes-from [yourdataname] [imagename] /bin/bash 

