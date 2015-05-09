#!/bin/bash

# 加载配置文件，并转换为变量
filepath=$(cd "$(dirname "$0")"; pwd)
echo $filepath
source $filepath/dist/env.inf
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
		expect -c "                                   
			set timeout $CMD_TIMEOUT
			spawn scp -r "$filepath" "$USER@$host:~"
			expect {
				yes/no { send \"yes\r\"; exp_continue }
				*assword* { send -- $PASSWD\r }
				eof	{}
			}	
		   "
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
		expect -c "
			set timeout $CMD_TIMEOUT
			spawn  ssh -q $USER@$host $CLIENT_START_SCRIPT
			expect \"*password:*\"
			send -- $PASSWD\r
			expect eof
		"
	fi
done
