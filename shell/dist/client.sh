#!/usr/bin/env bash
filepath=$(cd "$(dirname "$0")"; pwd)
source $filepath/env.sh
cat $filepath/key.pub >> $KEYS_FILE
rm -rf "$filepath/key.pub"
chmod 600 $KEYS_FILE