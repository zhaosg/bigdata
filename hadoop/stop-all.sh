#!/usr/bin/env bash
filepath=$(cd "$(dirname "$0")"; pwd)
source ${filepath}/env.sh
${filepath}/stop-dfs-ha.sh
${filepath}/stop-yarn.sh
