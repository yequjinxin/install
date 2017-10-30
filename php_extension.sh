#!/bin/bash

# redis
name=redis-3.1.4
name_tar=redis-3.1.4.tgz


cd /usr/local/src

if [ ! -f $name_tar ]; then
    echo "下载${name_tar}扩展文件"
    wget http://pecl.php.net/get/${name_tar}
fi
# 不存在下载压缩包，则退出程序
if [ ! -f $name_tar ]; then
    echo "${name_tar} not exists and upload error"
    exit 1
fi

tar -zxvf $name_tar
cd $name

phpize
./configure && make && make install



# swoole

name=swoole-1.9.21
name_tar=swoole-1.9.21.tgz

cd /usr/local/src

if [ ! -f $name_tar ]; then
    echo "下载${name_tar}扩展文件"
    wget http://pecl.php.net/get/${name_tar}
fi
# 不存在下载压缩包，则退出程序
if [ ! -f $name_tar ]; then
    echo "${name_tar} not exists and upload error"
    exit 1
fi

tar -zxvf $name_tar
cd $name

phpize
./configure && make && make install



# 扩展安装完成后，配置/usr/local/php/lib/php.ini
# 1. 修改扩展目录
# extension_dir = "/usr/local/php/lib/php/extensions/no-debug-non-zts-20160303/"
# 2. 在文件结尾添加扩展模块
# [extension]
# extension=redis.so
# extension=swoole.so
# zend_extension=opcache.so



