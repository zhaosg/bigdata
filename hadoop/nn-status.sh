#!/usr/bin/env bash
filepath=$(cd "$(dirname "$0")"; pwd)
source ${filepath}/env.sh
for nn in $namenodes
do
    expect -c "
     set timeout 80
     spawn ssh -q ${user}@${nn}  ${hadoop_home}/sbin/hadoop-daemon.sh start namenode
     expect {
         yes/no { send \"yes\r\"; exp_continue }
         *password:* {send -- ${password}\r}
     }
     expect eof
    "
done
