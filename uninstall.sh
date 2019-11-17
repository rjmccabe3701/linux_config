#!/bin/bash
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
source ${DIR}/functions.sh
if [ -f ${LINUX_CONFIG_PLUGIN_DIR}/custom_uninstall.sh ]
then
   ${LINUX_CONFIG_PLUGIN_DIR}/custom_uninstall.sh
fi
rm -rf ~/.oh-my-zsh
remove_files
rm -rf ~/.vim*
rm -rf ~/.tmux

