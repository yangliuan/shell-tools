#!/bin/sh
export PATH=/sbin:/bin:/usr/sbin:/usr/bin:/usr/local/sbin:/usr/local/bin:
clear
printf "
#######################################################################
    获取系统硬件信息
#######################################################################
"
# Check if user is root
[ $(id -u) != "0" ] && { echo "${CFAILURE}Error: You must be root to run this script${CEND}"; exit 1; }

printf "
厂商信息：
"
dmidecode|grep "System Information" -A9|egrep  "Manufacturer|Product|Serial"

printf "
主板信息：
"
dmidecode |grep -A16 "System Information$"

printf "
CPU信息：
"
lscpu

printf "
内存信息：
"
dmidecode -t memory | head -45 | tail -24

printf "
内存大小(GB)：
"
free -g

printf "
硬盘厂商：
"
fdisk -l |grep model

printf "
磁盘使用情况：
"
df -hT

printf "
操作系统信息：
"
lsb_release -a
cat /etc/redhat-release
cat /etc/centos-release
cat /etc/issue
