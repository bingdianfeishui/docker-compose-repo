
## 下载源码包
```
apk update
apk add  curl gcc make

cd ${HOME}

curl -fSL https://github.com/happyfish100/libfastcommon/archive/V1.0.36.tar.gz -o fastcommon.tar.gz
curl -fSL  https://codeload.github.com/happyfish100/fastdfs/tar.gz/V5.11 -o fastfs.tar.gz
curl -fSL  https://github.com/happyfish100/fastdfs-nginx-module/archive/master.tar.gz -o nginx-module.tar.gz
```
## 编译安装
```
# 安装编译环境
-- sudo apt-get install gcc make --
# 解包
tar zxvf fastcommon.tar.gz
tar zxvf fastfs.tar.gz
tar zxvf nginx-module.tar.gz
# 安装
cd libfastcommon-1.0.36/
./make.sh
./make.sh install

cd ../fastdfs-5.11/
./make.sh
./make.sh install
```

## 配置
```
mkdir -p /var/local/fdfs/storage /var/local/fdfs/tracker
cd /etc/fdfs/ && cp storage.conf.sample storage.conf && cp tracker.conf.sample tracker.conf

# tracker.fonc
sed -i "s|base_path=/home/yuqing/fastdfs|base_path=/var/local/fdfs/tracker|g" /etc/fdfs/tracker.conf
# 共有两处/home/yuqing/fastdfs需替换，运行下面的一条命令即可一次性替换完成
sed -i "s|/home/yuqing/fastdfs|/var/local/fdfs/storage|g" /etc/fdfs/storage.conf

# 设置trancer ip
~~ cat /proc/net/dev|grep ^eth0|awk -F: '{print $1}'| (read eth0;ifconfig $eth0)|grep inet\ |awk '{print $2}'|(read IP;sed -i "s|^tracker_server=.*$|tracker_server=${IP}:22122|g" /etc/fdfs/storage.conf;) ~~
ifconfig eth0|grep "inet"|awk '{print $2}'|awk -F: '{print $2}'|(read IP;sed -i "s|^tracker_server=.*$|tracker_server=${IP}:22122|g" /etc/fdfs/storage.conf;)

# 启动脚本
/etc/init.d/fdfs_trackerd start \
&& /etc/init.d/fdfs_storaged start

```

#### 获取网卡名称
cat /proc/net/dev|grep ^enp|awk -F: '{print $1}'
#### 获取ip地址
cat /proc/net/dev|grep ^enp|awk -F: '{print $1}'| (read eth0;ifconfig $eth0)|grep inet\ |awk '{print $2}'


## 安装nginx
```
curl -fSL http://nginx.org/download/nginx-1.12.2.tar.gz -o nginx-1.12.2.tar.gz
~~ sudo apt-get install libpcre3 libpcre3-dev zlib1g-dev openssl ~~
tar zxvf nginx-1.12.2.tar.gz
chmod u+x fastdfs-nginx-module-master/src/config
cd nginx-1.12.2
./configure --add-module=${HOME}/fastdfs-nginx-module-master/src
make && make install

# 复制并修改mod_fastdfs.conf
cp ${HOME}/fastdfs-nginx-module-master/src/mod_fastdfs.conf /etc/fdfs/
cat /proc/net/dev|grep ^enp|awk -F: '{print $1}'| (read eth0;ifconfig $eth0)|grep inet\ |awk '{print $2}'|(read IP;sed -i "s|^tracker_server=.*$|tracker_server=${IP}:22122|g" /etc/fdfs/mod_fastdfs.conf;)
sed -i "s|^store_path0.*$|store_path0=/var/local/fdfs/storage|g" /etc/fdfs/mod_fastdfs.conf
sed -i "s|^url_have_group_name =.*$|url_have_group_name = true|g" /etc/fdfs/mod_fastdfs.conf

cd ${HOME}/fastdfs-5.11/conf/ && cp http.conf mime.types anti-steal.jpg /etc/fdfs/

# 创建软连接
ln -s /var/local/fdfs/storage/data/ /var/local/fdfs/storage/data/M00

# 配置文件
echo -e "events {\n\
    worker_connections  1024;\n\
}\n\
http {\n\
    include       mime.types;\n\
    default_type  application/octet-stream;\n\

    server {\n\
        listen 8888;\n\
        server_name localhost;\n\

        location ~ /group[0-9]/M00 {\n\
            ngx_fastdfs_module;\n\
        }\n\
    }\n\
}">/usr/local/nginx/conf/nginx.conf

# 启动nginx
/usr/local/nginx/sbin/nginx


```
echo -e "/etc/init.d/fdfs_trackerd start \n\
/etc/init.d/fdfs_storaged start \n\
/usr/local/nginx/sbin/nginx \n\
">start.sh

