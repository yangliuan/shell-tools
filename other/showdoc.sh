#!/bin/bash
export PATH=/sbin:/bin:/usr/sbin:/usr/bin:/usr/local/sbin:/usr/local/bin:
clear
printf "
#######################################################################
                     非docker环境手动升级showdoc
#######################################################################
"
currentdate=$(date +%Y%m%d%H%M%S)
echo "当前时间${currentdate}"

UpgradeShowdoc(){
    echo "开始备份..."
    cp -rfv ${showdoc_dir} ${bk_dir}/showdoc_${currentdate}
    echo "备份完成"

    #切换到备份目录开始升级
    echo "开始覆盖升级..."
    pushd ${bk_dir} > /dev/null
    git clone git@gitee.com:star7th/showdoc.git showdoc_tmp
    #拷贝sqlite数据库文件到新代码
    cp -rfv ${showdoc_dir}/Sqlite/showdoc.db.php ./showdoc_tmp/Sqlite/
    #拷贝上传文件到
    cp -rfv ${showdoc_dir}/Public/Uploads/* ./showdoc_tmp/Public/Uploads/
    #拷贝升级后文件到原有安装目录
    cp -rfv ./showdoc_tmp/* ${showdoc_dir}/
    #修改文件权限
    chown -R ${run_user}.${run_user} ${showdoc_dir}/*
    chmod -R 755 ${showdoc_dir}/*
    rm -rf ./showdoc_tmp
    popd > /dev/null
    echo "升级完成,请访问showdoc测试"
}

while :; do echo
    read -e -p "请输入showdoc安装目录： " showdoc_dir
    if [ -n "${showdoc_dir}" -a -z "$(echo ${showdoc_dir} | grep '^/')" ]; then
        echo "输入的目录不合法！"     
    elif [ ! -d "${showdoc_dir}" ]; then
        echo "目录不存在";
    else
        echo "你的showdoc安装目录：${showdoc_dir}"
        break
    fi
done

while :; do echo
    echo "升级前备份防止数据丢失"
    read -e -p "请输入showdoc备份目录： " bk_dir
    if [ -n "${bk_dir}" -a -z "$(echo ${bk_dir} | grep '^/')" ]; then
        echo "输入的目录不合法！"     
    elif [ ! -d "${bk_dir}" ]; then
        mkdir ${bk_dir}
    else
        echo "你的showdoc备份目录：${bk_dir}"
        break
    fi
done

while :; do echo
    read -e -p "请输入php-fpm运行用户和用户组： " run_user
    if [ ! -n "${run_user}" ]; then
        echo "输入的用户名不存在！"     
    else
        echo "你的php-fpm运行用户和用户组：${run_user}"
        break
    fi
done

UpgradeShowdoc