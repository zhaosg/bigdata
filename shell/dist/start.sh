#!/bin/bash

# 加载配置文件
echo "------------------加载配置文件-----------------------------------"
filepath=$(cd "$(dirname "$0")"; pwd)
source $filepath/env.inf
hostname=`cat /etc/hostname`
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
		expect -c "
			set timeout $CMD_TIMEOUT;
			spawn scp $RSA_PUB "$USER@$host:$filepath/key.pub"
			expect {
				yes/no { send \"yes\r\"; exp_continue }
				*assword* { send -- $PASSWD\r }
			}
			expect	eof	
		"
	fi
done
# 执行需要在各个主机的脚本任务
echo "-----------------执行需要在各个主机的脚本任务-------------------------------"
for host in $HOSTS
do
	if [ $host != $hostname ];then
		if [ "$RESET_KEYS_FILE" == "1" ];then
			expect -c "
				set timeout $CMD_TIMEOUT
				spawn  ssh -q $USER@$host $CLIENT_CLEAR_SCRIPT
				expect {
					yes/no { send \"yes\r\"; exp_continue }
					*assword* { send -- $PASSWD\r }
				}
				expect	eof	
			"
		fi
		expect -c "
			set timeout $CMD_TIMEOUT
			spawn  ssh -q $USER@$host $CLIENT_SCRIPT
			expect {
				yes/no { send \"yes\r\"; exp_continue }
				*assword* { send -- $PASSWD\r }
			}
			expect	eof	
		"
	fi
done
