#!/usr/bin/env bash
filepath=$(cd "$(dirname "$0")"; pwd)
source ${filepath}/env.sh
local_files=${filepath}/etc/hadoop
for nn in $namenodes
do
    expect -c "
     set timeout 80
     spawn ssh -q ${user}@${nn}  ${hadoop_home}/bin/hdfs  haadmin -getServiceState  ${nn}
     expect {
         yes/no { send \"yes\r\"; exp_continue }
         *password:* {send -- ${password}\r}
     }
     expect eof
    "
done
