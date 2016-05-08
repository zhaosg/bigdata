#!/usr/bin/env bash
filepath=$(cd "$(dirname "$0")"; pwd)
source ${filepath}/env.sh
${filepath}/start-qjm.sh
${filepath}/format-zk.sh
${filepath}/format-dfs.sh