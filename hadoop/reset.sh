#!/usr/bin/env bash
filepath=$(cd "$(dirname "$0")"; pwd)
source ${filepath}/env.sh
local_files=${filepath}/etc/hadoop
for host in $hosts
do
    expect -c "
     set timeout 80
     spawn rm -rf ${hadoop_home}/logs/*
     spawn ssh -q ${user}@${host} "rm -rf ${hadoop_home}/logs/*"
     expect {
         yes/no { send \"yes\r\"; exp_continue }
         *password:* {send -- ${password}\r}
     }
     expect eof
    "
done


