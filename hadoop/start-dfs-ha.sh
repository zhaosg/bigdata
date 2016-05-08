#!/usr/bin/env bash
filepath=$(cd "$(dirname "$0")"; pwd)
source ${filepath}/env.sh
${filepath}/start-zk.sh
${filepath}/start-qjm.sh
${filepath}/start-nn.sh
${filepath}/start-dn.sh
