
# install docker-ce and docker-compose on ubuntu

## 1. 修改为国内源
### 备份并编辑
```
$ sudo cp /etc/apt/source.list /etc/apt/source.list.bak
$ sudo nano /etc/apt/source.list
```
### 注释掉光盘源及官方源

> 注释掉以下面开头的源(注释即在行首加#)

```
# deb cdrom:[Ubuntu-Server 16.04.3 LTS _Xenial Xerus
# deb http://cn.archive.ubuntu.com/ubuntu/
# deb http://security.ubuntu.com/ubuntu 
```

### 添加国内源

> 在文件末尾加入如下内容:

```
# 163 注释掉源码源
deb http://mirrors.163.com/ubuntu/ xenial main restricted universe multiverse
deb http://mirrors.163.com/ubuntu/ xenial-security main restricted universe multiverse
deb http://mirrors.163.com/ubuntu/ xenial-updates main restricted universe multiverse
deb http://mirrors.163.com/ubuntu/ xenial-proposed main restricted universe multiverse
deb http://mirrors.163.com/ubuntu/ xenial-backports main restricted universe multiverse
# deb-src http://mirrors.163.com/ubuntu/ xenial main restricted universe multiverse
# deb-src http://mirrors.163.com/ubuntu/ xenial-security main restricted universe multiverse
# deb-src http://mirrors.163.com/ubuntu/ xenial-updates main restricted universe multiverse
# deb-src http://mirrors.163.com/ubuntu/ xenial-proposed main restricted universe multiverse
# deb-src http://mirrors.163.com/ubuntu/ xenial-backports main restricted universe multiverse

# aliyun 注释掉src源
deb http://mirrors.aliyun.com/ubuntu/ xenial main restricted universe multiverse
deb http://mirrors.aliyun.com/ubuntu/ xenial-security main restricted universe multiverse
deb http://mirrors.aliyun.com/ubuntu/ xenial-updates main restricted universe multiverse
deb http://mirrors.aliyun.com/ubuntu/ xenial-backports main restricted universe multiverse
deb http://mirrors.aliyun.com/ubuntu/ xenial-proposed main restricted universe multiverse 
# 源码
# deb-src http://mirrors.aliyun.com/ubuntu/ xenial main restricted universe multiverse
# deb-src http://mirrors.aliyun.com/ubuntu/ xenial-security main restricted universe multiverse
# deb-src http://mirrors.aliyun.com/ubuntu/ xenial-updates main restricted universe multiverse
# deb-src http://mirrors.aliyun.com/ubuntu/ xenial-backports main restricted universe multiverse
# deb-src http://mirrors.aliyun.com/ubuntu/ xenial-proposed main restricted universe multiverse
```

## 2. 安装docker-ce

### 安装必要环境

```
$ sudo apt-get -y install apt-transport-https ca-certificates curl software-properties-common
```

### 添加docker-ce源地址

** For [aliyun docker-ce repository](https://yq.aliyun.com/articles/110806?commentId=11066)(推荐，速度快) **

```
$ curl -fsSL http://mirrors.aliyun.com/docker-ce/linux/ubuntu/gpg | sudo apt-key add -
$ sudo add-apt-repository "deb [arch=amd64] http://mirrors.aliyun.com/docker-ce/linux/ubuntu $(lsb_release -cs) stable"
```

** For [official docker-ce repository](https://docs.docker.com/engine/installation/linux/docker-ce/ubuntu/#set-up-the-repository) **

```
$ curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
$ sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"
```

### 安装docker-ce

```
$ sudo apt-get -y update
$ sudo apt-get -y install docker-ce
```

### 修改镜像地址

```
$ sudo vim /etc/docker/daemon.json

	# input below and save
	{
	  "registry-mirrors": ["https://registry.docker-cn.com"]
	}
$ sudo /etc/init.d/docker restart
```

### 安装 docker-compose
```
$ sudo curl -L https://github.com/docker/compose/releases/download/1.17.1/docker-compose-`uname -s`-`uname -m` -o /usr/local/bin/docker-compose
$ sudo chmod +x /usr/local/bin/docker-compose
$ docker-compose --version
docker-compose version 1.17.1, build 1719ceb
```