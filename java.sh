#!/bin/bash


# 变量
name=jdk-8u152-linux-x64
name_tar=${name}.tar.gz
target_dir=/usr/local/jdk
target_dir_bak=/usr/local/jdk_bak


# 文件已经存在，则备份
if [ -d $target_dir ]; then
    echo "${target_dir}已经存在"
    rm -rf $target_dir_bak
    mv $target_dir $target_dir_bak
fi

# 下载
cd /usr/local/src
if [ ! -f $name_tar ]; then
    wget http://download.oracle.com/otn-pub/java/jdk/8u152-b16/aa0333dd3019491ca4f6ddbe78cdb6d0/jdk-8u152-linux-x64.tar.gz?AuthParam=1510284842_a2aa463703a4afe75e7eb42b01f1711f -O $name_tar
fi

if [ ! -f $name_tar ]; then
    echo "${name_tar} not exists and upload error"
    exit 1
fi

tar -zxvf $name_tar
mv $name ../jdk

# 添加环境变量
echo "export JAVA_HOME=/usr/local/jdk" >> /etc/profile
echo "PATH=$JAVA_HOME/bin:$PATH" >> /etc/profile

source /etc/profile
