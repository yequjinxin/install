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
    wget https://nodejs.org/dist/v6.11.5/${name_tar}
fi

if [ ! -f $name_tar ]; then
    echo "下载node文件失败"
    exit 1
fi

tar -Jxvf $name_tar
mv $name ../node

rm -rf /usr/local/sbin/node
rm -rf /usr/local/sbin/npm
rm -rf /usr/local/sbin/cnpm
rm -rf /usr/local/sbin/pm2

ln -s /usr/local/node/bin/node /usr/local/sbin/node
ln -s /usr/local/node/bin/npm /usr/local/sbin/npm

# 安装 cnpm
npm install -g cnpm --registry=https://registry.npm.taobao.org
ln -s /usr/local/node/bin/cnpm /usr/local/sbin/cnpm

# 安装pm2
cnpm install pm2 -g
ln -s /usr/local/node/bin/pm2 /usr/local/sbin/pm2
###
# 启动
# pm2 start index --log-date-format "YYYY-MM-DD HH:mm:ss Z"
# 更新
# pm2 save
# cnpm install pm2@latest -g
# pm2 update
###
