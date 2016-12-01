#!/bin/bash

if [ -z $1 ]; then
    version=1.10.2
else
    version=$1
fi
slash='--------------------------------------------------------'
echo "nginx ${version} begin install ${slash}" 

# 变量
name=nginx-${version}
name_tar=${name}.tar.gz
target_dir=/usr/local/nginx


if [ -d $target_dir ]; then
    echo "删除${target_dir} ${slash}"
    rm -rf $target_dir
fi

cd /usr/local/src
#http://nginx.org/download/nginx-1.11.6.tar.gz


if [ ! -f $name_tar ]; then
    echo "下载nginx文件 ${slash}"
    wget http://nginx.org/download/${name_tar}
fi

if [ ! -f $name_tar ]; then
    echo "${name_tar} not exists and upload error ${slash}"
    exit 1 
fi

yum -y update
# 安装编译工具:
yum install -y gcc automake autoconf libtool gcc-c++
# 安装基础库
yum install -y gd zlib zlib-devel openssl openssl-devel libxml2 libxml2-devel libjpeg libjpeg-devel libpng libpng-devel freetype freetype-devel libmcrypt libmcrypt-devel bzip2 bzip2-devel curl curl-devel

if [ -d $name ]; then
    make clean
else
    tar -zxvf $name_tar
fi

cd $name
./configure --prefix=$target_dir
make && make install

echo "nginx install success ${slash}"

