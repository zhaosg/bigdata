#!/usr/bin/env bash
filepath=$(cd "$(dirname "$0")"; pwd)
source ${filepath}/env.sh
${filepath}/stop-zk.sh
${filepath}/stop-qjm.sh
${filepath}/stop-nn.sh
${filepath}/stop-dn.sh