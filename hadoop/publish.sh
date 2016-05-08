#!/usr/bin/env bash
hosts="nn01 nn02 nn03 nn04 dn01 dn02 dn03"
user=zhaosg
password=mima0704
hadoop_conf=/opt/app/hadoop-2.6.2/etc
filepath=$(cd "$(dirname "$0")"; pwd)
local_files=${filepath}/conf1/etc/hadoop

for host in $hosts
do
    expect -c "
     set timeout 80
     spawn scp -r ${local_files} ${user}@${host}:${hadoop_conf}
     expect {
         yes/no { send \"yes\r\"; exp_continue }
         *password:* {send -- ${password}\r}
     }
     expect eof
    "
done