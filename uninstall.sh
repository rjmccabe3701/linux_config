#!/bin/bash
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
source ${DIR}/functions.sh
[ uninstall_oh_my_zsh ] || rm -rf ~/.oh-my-zsh
remove_files
rm -rf ~/.vim*
rm -rf ~/.tmux

