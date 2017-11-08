#!/bin/sh

name=supervisor-3.3.3
name_tar=${name}.tar.gz

cd /usr/local/src

if [ ! -f $name_tar ]; then
    echo "下载${name_tar}扩展文件"
    wget https://pypi.python.org/packages/31/7e/788fc6566211e77c395ea272058eb71299c65cc5e55b6214d479c6c2ec9a/${name_tar}
fi
# 不存在下载压缩包，则退出程序
if [ ! -f $name_tar ]; then
    echo "${name_tar} not exists and upload error"
    exit 1
fi

tar -zxvf $name_tar
cd $name

python setup.py install

echo_supervisord_conf > /etc/supervisord.conf

# supervisord -c /etc/supervisord.conf
# supervisorctl status
