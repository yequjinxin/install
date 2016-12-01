#!/bin/bash

if [ -z $1 ]; then
    version=7.0.13
else
    version=$1
fi
slash='--------------------------------------------------------'
echo "php ${version} begin install ${slash}"

# 变量
name=php-${version}
name_tar=${name}.tar.gz
target_dir=/usr/local/php

if [ -d $target_dir ]; then
    echo "删除${target_dir} ${slash}"
    rm -rf $target_dir
fi

cd /usr/local/src

if [ ! -f $name_tar ]; then
    echo "下载nginx文件 ${slash}"
    wget http://au1.php.net/get/${name_tar}/from/this/mirror -O $name_tar
fi

if [ ! -f $name_tar ]; then
    echo "${name_tar} not exists and upload error ${slash}"
    exit 1
fi


yum update -y
yum install -y gcc automake autoconf libtool gcc-c++
yum install -y epel-release
yum install -y gd zlib zlib-devel openssl openssl-devel libxml2 libxml2-devel libjpeg libjpeg-devel libpng libpng-devel freetype freetype-devel libmcrypt libmcrypt-devel bzip2 bzip2-devel curl curl-devel



if [ -d $name ]; then
    make clean
else
    tar -zxvf $name_tar
fi

cd $name

./configure --prefix=$target_dir \
--with-gd \
--with-freetype-dir \
--with-jpeg-dir \
--enable-gd-native-ttf \
--enable-gd-jis-conv \
--enable-mysqlnd \
--with-pdo-mysql=mysqlnd \
--with-mysqli \
--with-openssl \
--with-mcrypt \
--with-curl \
--enable-mbstring \
--enable-zip \
--enable-fpm

make && make install

cp /usr/local/src/${name}/php.ini-development ${target_dir}/lib/php.ini
cp ${target_dir}/etc/php-fpm.conf.default ${target_dir}/etc/php-fpm.conf
cp ${target_dir}/etc/php-fpm.d/www.conf.default ${target_dir}/etc/php-fpm.d/www.conf


# 添加用户
userdel www
groupadd www
useradd -r -g www -s /bin/false www

#user和group设置为www
#vim php.ini 将date.timezone设置为PRC

echo "安装成功,请自行配置时区(PRC)和用户和用户组(www) ${slash}"
