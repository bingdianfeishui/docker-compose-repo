#!/bin/sh

DIR=$(cd `dirname $0`; pwd)
cd $DIR

CMD=""

if [ "$1" = "" ] ; then
    echo ERROR: parameter start\|stop  missing.
elif [ "$1" = "start" ] ; then
    
	# 自定义bridge网络：mynet
	MYNET=`docker network ls|grep mynet`
	if [ -z ${MYNET} ]; then
		echo "mynet does not exists. Createing..."
		docker network create -d bridge mynet
	fi

	# 准备数据文件夹
	if [ ! -d "${HOME}/docker-data/fdfs" ] ; then
		# fastdfs数据文件夹
		echo "Creating fastdfs dir ${HOME}/docker-data/fdfs ..."
		mkdir -p ${HOME}/docker-data/fdfs
	fi
    if [ ! -d "${HOME}/docker-data/solr-home" ] ; then
		# solr数据文件夹
        echo "Copy solr-home to ${HOME}/docker-data/ ..."
        cp -r solr/solr-home ${HOME}/docker-data/
    fi
    
    # 更新fastfs的IP, 此处也可直接填写虚拟机IP
    #IP=`ifconfig enp0s8 | grep inet | awk '{print $2}'| awk -F: '{print $2}'`
    IP=192.168.0.110
    sed -i "s|IP=.*$|IP=${IP}|g" fastdfs/docker-compose.yaml
    
    echo BATCH START: activemq, fastdfs,redis-single, solr, zookeeper
    
    CMD="start"
elif [ "$1" = "stop" ]; then
	echo BATCH STOP...
	CMD="stop"
elif [ "$1" == "rm" -o "$1" == "del" -o "$1" == "delete" ]; then
	echo BATCH RM...
	CMD="rm"
fi

cd activemq
docker-compose ${CMD}
cd ..

cd fastdfs
docker-compose ${CMD}
cd ..

cd redis
docker-compose ${CMD}
cd ..

cd solr
docker-compose ${CMD}
cd ..

cd zookeeper
docker-compose ${CMD}
cd ..

