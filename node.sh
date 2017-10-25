#!/bin/bash

name=node-v6.11.5-linux-x64
name_tar=node-v6.11.5-linux-x64.tar.xz

target_dir=/usr/local/node
target_dir_bak=/usr/local/node_bak

# /usr/local/node已经存在，则备份
if [ -d $target_dir ]; then
    echo "${target_dir}已经存在"
    rm -rf $target_dir_bak
    mv $target_dir $target_dir_bak
fi

cd /usr/local/src
if [ ! -f $name_tar ]; then
    echo "下载node文件"
    wget https://nodejs.org/dist/v6.11.5/node-v6.11.5-linux-x64.tar.xz
fi

if [ ! -f $name_tar ]; then
    echo "下载node文件失败"
    exit 1
fi

tar -Jxvf node-v6.11.2-linux-x64.tar.xz
mv node-v6.11.2-linux-x64 ../node

ln -s /usr/local/node/bin/node  /usr/local/sbin/node
ln -s /usr/local/node/bin/npm /usr/local/sbin/npm
npm install -g cnpm --registry=https://registry.npm.taobao.org
ln -s /usr/local/node/bin/cnpm /usr/local/sbin/cnpm