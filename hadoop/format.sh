#!/usr/bin/env bash
filepath=$(cd "$(dirname "$0")"; pwd)
source ${filepath}/env.sh
${filepath}/start-jn.sh
${filepath}/format-zk.sh
${filepath}/format-dfs.sh