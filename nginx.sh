#!/bin/bash

if [ -z $1 ]; then
    version=1.12.1
else
    version=$1
fi


# 变量
name=nginx-${version}
name_tar=${name}.tar.gz
target_dir=/usr/local/nginx
target_dir_bak=/usr/local/nginx_bak

if [ -d $target_dir ]; then
    echo "{target_dir}存在, 备份${target_dir}"
    rm -rf $target_dir_bak
    mv $target_dir $target_dir_bak
fi

cd /usr/local/src
#http://nginx.org/download/nginx-1.11.6.tar.gz

if [ ! -f $name_tar ]; then
    echo "下载nginx文件"
    wget http://nginx.org/download/${name_tar}
fi

if [ ! -f $name_tar ]; then
    echo "${name_tar} not exists and upload error"
    exit 1
fi

echo "nginx ${version} begin install" 
yum -y update
# 安装编译工具:
yum install -y gcc automake autoconf libtool gcc-c++
# 安装基础库
yum install -y gd zlib zlib-devel openssl openssl-devel libxml2 libxml2-devel libjpeg libjpeg-devel libpng libpng-devel freetype freetype-devel libmcrypt libmcrypt-devel bzip2 bzip2-devel curl curl-devel pcre pcre-devel

if [ -d $name ]; then
    cd $name
    make clean
else
    tar -zxvf $name_tar
    cd $name
fi

useradd wwwroot
./configure --prefix=$target_dir --user=wwwroot --group=wwwroot
make && make install

rm -rf /usr/local/sbin/nginx
rm -rf /usr/sbin/nginx
rm -rf /etc/nginx
#rm -rf /etc/nginx/nginx.conf
#rm -rf /etc/nginx/mime.types

ln -s ${target_dir}/sbin/nginx /usr/local/sbin/nginx
ln -s ${target_dir}/sbin/nginx /usr/sbin/nginx
ln -s ${target_dir}/conf /etc/nginx

#if [ ! -d '/etc/nginx' ]; then
#    mkdir /etc/nginx
#fi
#ln -s ${target_dir}/conf/nginx.conf /etc/nginx/nginx.conf
#ln -s /usr/local/nginx/conf/mime.types /etc/nginx/mime.types

cd /etc/init.d
rm -rf nginx
wget http://doc.ranlau.com/nginx -O nginx
chmod a+x nginx
chkconfig --add /etc/init.d/nginx
chkconfig nginx on

echo "nginx install success"

