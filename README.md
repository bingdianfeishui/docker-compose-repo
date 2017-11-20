# docker-compose-repo
repo of docker images using docker-compose 

docker-compose配置文件仓库，包含常用solr/activeMQ/redis/zookeeper/fastdf等docker容器配置，用于快速搭建个人开发环境。

1、对于activeMQ，请先下载安装包到activemq文件夹，并根据实际修改Dockerfile中activemq的文件名。
2、对于fastdfs，请根据自己的机器ip修改fastdfs/docker-compose.sh文件里的IP值。
3、./compose.sh 仅启动了一些常用的开发环境，若要启动其他的，请手动cd到相应目录执行docker-compose up -d.
4、由于需在/home文件夹下创建子文件夹，所以请使用root权限运行compose.sh
