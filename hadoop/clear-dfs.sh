#!/usr/bin/env bash
filepath=$(cd "$(dirname "$0")"; pwd)
source ${filepath}/env.sh
for host in $hosts
do
    expect -c "
     set timeout 80
     spawn ssh -q ${user}@${host}  rm -rf /opt/data/hadoop
     expect {
         yes/no { send \"yes\r\"; exp_continue }
         *password:* {send -- ${password}\r}
     }
     expect eof
    "
done