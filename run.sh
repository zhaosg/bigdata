#!/bin/bash
#---------------------------------------
# 复制文件到远程主机，然后启动
#---------------------------------------
source shell/dist/env.conf
source ./shell/dist/funs.sh
copyDir2RemoteHost $USER nn01 $PASSWD ./shell ~
invokeRemoteHostCommand $USER nn01 $PASSWD ~/shell/start.sh