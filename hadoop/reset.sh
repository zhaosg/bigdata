#!/usr/bin/env bash
filepath=$(cd "$(dirname "$0")"; pwd)
source ${filepath}/env.sh
${filepath}/stop-dfs-ha.sh
${filepath}/clear.sh
${filepath}/format.sh
${filepath}/start-dfs-ha.sh