#!/usr/bin/env bash

# 加载配置文件，并转换为变量
filepath=$(cd "$(dirname "$0")"; pwd)
echo $filepath
source $filepath/dist/funs.sh
source $filepath/dist/env.sh
HOSTS=`cat $SUB_TASK_DIR/hosts`

chmod 700 $CLIENT_START_SCRIPT
chmod 700 $CLIENT_SCRIPT
chmod 700 $CLIENT_CLEAR_SCRIPT
hostname=`cat /etc/hostname`


# 分发文件到各个主机
echo "-----------------分发文件到各个主机-----------------------开始----------"
for host in $HOSTS 
do
	if [ $host != $hostname ];then
		echo "分发子任务脚本到$host"
		copyDir2RemoteHost $USER $host $PASSWD "$filepath" ~
	fi
done
echo "-------------------分发文件到各个主机-------------------结束----------"


$CLIENT_START_SCRIPT -c
# 执行需要在各个主机的脚本任务
echo "-----------------执行需要在各个主机的脚本任务-------------------------------"
for host in $HOSTS
do
	echo "分发子任务脚本到$host"
	if [ $host != $hostname ];then
		invokeRemoteHostCommand $USER $host $PASSWD $CLIENT_START_SCRIPT
	fi
done
