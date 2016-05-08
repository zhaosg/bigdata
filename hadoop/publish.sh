#!/usr/bin/env bash
filepath=$(cd "$(dirname "$0")"; pwd)
source ${filepath}/env.sh
local_files=${filepath}/etc/hadoop
for host in $hosts
do
    expect -c "
     set timeout 80
     spawn scp -r ${local_files} ${user}@${host}:${hadoop_home}/etc
     expect {
         yes/no { send \"yes\r\"; exp_continue }
         *password:* {send -- ${password}\r}
     }
     expect eof
    "
done