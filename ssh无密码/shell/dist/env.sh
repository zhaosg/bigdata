#!/usr/bin/env bash
USER=zhaosg
PASSWD=mima0704
SUB_TASK_DIR="/home/$USER/shell/dist"
CLIENT_SCRIPT="$SUB_TASK_DIR/client.sh"
CLIENT_START_SCRIPT="$SUB_TASK_DIR/start.sh"
CLIENT_CLEAR_SCRIPT="$SUB_TASK_DIR/clear.sh"
SSH_LOC="/home/$USER/.ssh"
RSA_FILE="$SSH_LOC/id_rsa"
RSA_PUB="$SSH_LOC/id_rsa.pub"
KEYS_FILE="$SSH_LOC/authorized_keys"
RESET_KEYS_FILE=1
CMD_TIMEOUT=80