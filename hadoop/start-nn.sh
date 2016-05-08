#!/usr/bin/env bash
filepath=$(cd "$(dirname "$0")"; pwd)
source ${filepath}/env.sh
local_files=${filepath}/etc/hadoop
for nn in $namenodes
do
    if [ "${nn}" != "${namenode}" ];then
        expect -c "
         set timeout 80
         spawn ssh -q ${user}@${nn}  ${hadoop_home}/bin/hdfs namenode -bootstrapStandby -force
         expect {
             yes/no { send \"yes\r\"; exp_continue }
             *password:* {send -- ${password}\r}
         }
         expect eof
        "

    fi
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