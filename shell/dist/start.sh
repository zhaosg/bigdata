#!/usr/bin/env bash
# 加载配置文件
echo "------------------加载配置文件-----------------------------------"
filepath=$(cd "$(dirname "$0")"; pwd)
source $filepath/env.sh
source $filepath/funs.sh
hostname=`cat /etc/hostname`
HOSTS=`cat $SUB_TASK_DIR/hosts.conf`
RESET_KEYS_FILE=0
for arg in "$@"
do
	if [ $arg == "-c" ];then
		RESET_KEYS_FILE=1
	fi	
done
if [ "$RESET_KEYS_FILE" == "1" ];then
	if [ ! -d "$SSH_LOC" ];then   
		mkdir ~/.ssh 
		chmod 700 ~/.ssh
	fi
	rm -rf "~/.ssh/*"
fi
# 生成ssh认证信息
echo "------------------生成ssh认证信息-----------------------------------"
cd ~/.ssh
rm -rf $RSA_FILE
ssh-keygen -t rsa -P '' -f $RSA_FILE
cat $RSA_PUB >> $KEYS_FILE
# 分发文件到各个主机
echo "-----------------分发文件到各个主机---------------------------------"
for host in $HOSTS 
do
	if [ $host != $hostname ];then
		echo "复制公钥文件到$host:$filepath/key.pub"
		copyFile2RemoteHost $USER $host $PASSWD $RSA_PUB $filepath/key.pub
	fi
done
# 执行需要在各个主机的脚本任务
echo "-----------------执行需要在各个主机的脚本任务-------------------------------"
for host in $HOSTS
do
	if [ $host != $hostname ];then
		if [ "$RESET_KEYS_FILE" == "1" ];then
			invokeRemoteHostCommand $USER $host $PASSWD $CLIENT_CLEAR_SCRIPT
		fi
		invokeRemoteHostCommand $USER $host $PASSWD $CLIENT_SCRIPT
	fi
done
