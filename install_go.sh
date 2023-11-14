#!/bin/bash

# 更新系统包
sudo apt update

# 卸载旧版本的 Go（如果已安装）
sudo apt remove --autoremove golang-go
sudo rm -rf /usr/local/go

# 获取最新版本的 Go 二进制文件
GO_LATEST=$(curl -s https://golang.org/VERSION?m=text)
if [[ $GO_LATEST == go* ]]; then
    GO_URL="https://dl.google.com/go/${GO_LATEST}.linux-amd64.tar.gz"
    
    # 打印出下载 URL
    echo "下载 URL: $GO_URL"
    
    # 下载并解压 Go
    curl -L $GO_URL | sudo tar -C /usr/local -xzf -

    # 设置环境变量
    echo "export PATH=\$PATH:/usr/local/go/bin" >> $HOME/.profile
    source $HOME/.profile

    # 验证安装
    go version
else
    echo "无法获取 Go 的最新版本"
fi
