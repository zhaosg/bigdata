#!/usr/bin/env bash
#---------------------------------------
# 复制文件到远程主机
# $1 用户名
# $2 主机名
# $3 密码
# $4 本地文件名
# $5 远程文件名
#---------------------------------------
function copyFile2RemoteHost {
    expect -c "
        set timeout 80
        spawn scp $4 $1@$2:$5
        expect {
            yes/no { send \"yes\r\"; exp_continue }
            *password:* {send -- $3\r}
        }
        expect eof
       "
}

#---------------------------------------
# 复制文件夹到远程主机
# $1 用户名
# $2 主机名
# $3 密码
# $4 本地文件夹名
# $5 远程文件夹名
#---------------------------------------
function copyDir2RemoteHost {
    expect -c "
        set timeout 80
        spawn scp -r $4 $1@$2:$5
        expect {
            yes/no { send \"yes\r\"; exp_continue }
            *password:* {send -- $3\r}
        }
        expect eof
       "
}

#---------------------------------------
# 执行远程主机的命令
# $1 用户名
# $2 主机名
# $3 密码
# $4 远程命令
#---------------------------------------
function invokeRemoteHostCommand {
    expect -c "
        set timeout 80
        spawn ssh -q $1@$2 $4
        expect {
            yes/no { send \"yes\r\"; exp_continue }
            *password:* {send -- $3\r}
        }
        expect eof
       "
}