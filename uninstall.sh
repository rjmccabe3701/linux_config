#!/bin/bash
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
source ${DIR}/functions.sh
[ ~/.spf13-vim-3/uninstall.sh ] && rm -rf ~/.spf13-vim-3
[ uninstall_oh_my_zsh ] || rm -rf ~/.oh-my-zsh
remove_files
rm -rf ~/.spf13-vim-3/
rm -rf ~/.vim*

