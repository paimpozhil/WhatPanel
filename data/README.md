### This is the Standard Data container for WhatPanel

It provides the following volumes which can be used from the other Containers. 
/data 
/backup 
/var/lib/mysql 
/var/www 

Our other standard containers like 
Apache/Nginx/etc will use these volumes to persist their data. You can 
add more volumes in Dockerfile if you wish to OR you can just use the 
subdirectories under /data for postgres/etc.

#### how to build
docker build -t stddata .

#### how to start a data volume
docker run -td --name appdata stddata

#### how to use in other containers
docker run -ti --name whatever --volumes-from appdata ubuntu /bin/bash 

On our dPanel however each Datacontainer WILL be named as the sitename 
and will be auto linked to every other container that is started 
together.
