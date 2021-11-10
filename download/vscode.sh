#!bin/bash
#下载vscode国内资源并安装
read -p "请输入vscode国外下载链接：" forei_url
cn_url="http://vscode.cdn.azure.cn/stable/${forei_url#*stable/}"
wget -P ~/Downloads $cn_url
file_name="code${forei_url#*/code*}"
sudo dpkg -i ~/Downloads/${file_name}
sudo rm -rf ~/Downloads/${file_name}