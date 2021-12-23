#! /bin/bash
export PATH=/sbin:/bin:/usr/sbin:/usr/bin:/usr/local/sbin:/usr/local/bin:
clear
printf "
#######################################################################
                             日志文件清理脚本
#######################################################################
"
#使用find命令
#find /xxx/xxx -type f -mtime +30 -name "*.log" -exec rm -rf {} \;

#日志目录
log_dir[0]=/home/yangliuan/Downloads/a_log
#删除x天以前的日志
day_number=30

for item in "${log_dir[@]}"; do
    if  [ -d "${item}" ]; then 
        echo start delete log ${day_number} days ago...
        find ${item} -type f -mtime +${day_number} -name "*.log" -exec rm -rf {} \;
        echo delete dir:${item} log success...
    fi
done