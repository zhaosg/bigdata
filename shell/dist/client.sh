#!/bin/bash
filepath=$(cd "$(dirname "$0")"; pwd)
source $filepath/env.inf
cat $filepath/key.pub >> $KEYS_FILE
rm -rf "$filepath/key.pub"
chmod 600 $KEYS_FILE