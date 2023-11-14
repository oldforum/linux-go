#!/bin/bash

# 检查是否具有root权限
if [ "$EUID" -ne 0 ]; then
  echo "请使用root权限运行此脚本。"
  exit 1
fi

# 定义安装目录
INSTALL_DIR="/usr/local"

# 获取最新版本的Go语言下载链接
GO_DOWNLOAD_URL=$(curl -s https://golang.org/dl/ | grep -o -m 1 'https://dl.google.com/go/go[0-9]\+\(\.[0-9]\+\)\+\.linux-amd64.tar.gz')

# 下载并解压Go二进制文件
echo "正在下载并安装最新版本的Go语言..."
curl -O $GO_DOWNLOAD_URL
tar -C $INSTALL_DIR -xzf $(basename $GO_DOWNLOAD_URL)
rm $(basename $GO_DOWNLOAD_URL)

# 配置Go环境变量
echo "配置Go环境变量..."
echo "export PATH=\$PATH:$INSTALL_DIR/go/bin" >> /etc/profile
echo "export GOPATH=\$HOME/go" >> /etc/profile
echo "export PATH=\$PATH:\$GOPATH/bin" >> /etc/profile
source /etc/profile

# 验证Go安装
installed_version=$(go version)
if [[ $installed_version == *"go"* ]]; then
  echo "Go语言安装成功。"
else
  echo "安装可能出现问题，请检查。"
fi
