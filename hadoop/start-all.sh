#!/usr/bin/env bash
filepath=$(cd "$(dirname "$0")"; pwd)
source ${filepath}/env.sh
${filepath}/start-dfs-ha.sh
${filepath}/start-yarn.sh
