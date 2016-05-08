#!/usr/bin/env bash
filepath=$(cd "$(dirname "$0")"; pwd)
source ${filepath}/env.sh
local_files=${filepath}/etc/hadoop
expect -c "
 set timeout 80
 spawn ssh -q ${user}@${namenode}  ${hadoop_home}/sbin/hadoop-daemons.sh stop journalnode
 expect {
     yes/no { send \"yes\r\"; exp_continue }
     *password:* {send -- ${password}\r}
 }
 expect eof
"