#!/usr/bin/env bash
filepath=$(cd "$(dirname "$0")"; pwd)
source $filepath/env.sh
if [ "$RESET_KEYS_FILE" == "1" ];then
	if [ ! -d "$SSH_LOC" ];then  
		mkdir ~/.ssh
		chmod 700 ~/.ssh
	fi
	rm -rf "~/.ssh/*"
fi