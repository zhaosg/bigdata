#!/usr/bin/env bash
hosts="nn01 nn02 nn03 nn04 dn01 dn02 dn03"
for i in $hosts
do
    scp ./conf1/* zhaosg@${i}:/opt/app/hadoop-2.6.2/etc/hadoop
done