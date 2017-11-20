#!/bin/bash

ID=`docker ps|grep my_solr|awk '{print $1}'`
echo my_solr.ID:$ID
docker exec -it $ID /usr/bin/tail -f /opt/solr/server/logs/catalina.out
