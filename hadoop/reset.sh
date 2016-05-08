#!/usr/bin/env bash
filepath=$(cd "$(dirname "$0")"; pwd)
source ${filepath}/env.sh

rm -rf /opt/app/hadoop-2.6.2/logs/*
rm -rf /opt/data/hadoop/