# docker-compose-repo

> docker-compose配置文件仓库，包含常用solr/activeMQ/redis/zookeeper/fastdfs等docker容器配置，用于快速搭建个人开发环境。在VirtualBox+Ubuntu虚拟机环境下及debian 9实体机上使用正常。

## 虚拟机测试环境
* Ubuntu Server 16.04 x64
* Virtual Box 5.2.0

## 前期准备
**如在实体linux系统机器上安装docker则不需要此步**
### 1. 安装Virtual Box
略。
### 2. 在VBox内安装Ubuntu虚拟机(以下简称客户机)
略。如需用ssh，请勾选安装OpenSSH server。
### 3. 配置客户机网络
请见[Ubuntu + Virtual Box 双网卡上内外网配置](./Ubuntu_VBox_Dual_NICs_Config.md).

## 安装docker-ce和docker-compose
请见[Ubuntu docker 安装教程](./ubuntu_docker_install_tutorial.md).

## 启动

### 1. 使用ssh客户端将所有文件复制到客户机中，或直接从github clone。

### 2. 启动前准备工作

a. 对于activeMQ，请先下载安装包到activemq文件夹，并根据实际修改activemq/Dockerfile中activemq安装包的文件名。如
```
ADD ./apache-activemq-5.14.5-bin.tar.gz /
```
b. 对于fastdfs，请将fastdfs/docker-compose.sh文件里的IP值改为自己的虚拟机的Host-Only ip，如`192.168.56.110`。

c. 添加执行权限并初始化
```
$ chmod u+x compose.sh
$ ./compose.sh init
```

### 启动常用开发环境(均为单机版): solr, zookeeper, fastdfs, redis, activemq
```
$ ./compose.sh start
```

注意：
`compose.sh `仅启动了一些常用的开发环境，若要启动其他的容器，请手动cd到相应目录执行docker-compose up -d.

<em style='color:red'>顺便安利一个SSH客户端，mobaXterm，已用多年，墙裂推荐。</em>
