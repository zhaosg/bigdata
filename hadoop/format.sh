#!/usr/bin/env bash
filepath=$(cd "$(dirname "$0")"; pwd)
source ${filepath}/env.sh
${filepath}/format-zk.sh
${filepath}/start-qjm.sh
${filepath}/format-dfs.sh
${filepath}/stop-qjm.sh