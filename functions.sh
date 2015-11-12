#!/bin/bash
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

#files=(tmux.conf gitconfig vimrc.before.local vimrc.bundles.local vimrc.local)
files=(tmux.conf gitconfig vimrc.before.local vimrc.local)
scripts=$(find ${DIR}/scripts -type f)

function install_files()
{
    for f in ${files[@]}
    do
        ln -sf ${DIR}/${f} ~/.${f}
    done

    mkdir -p ~/scripts
    for f in ${scripts[@]}
    do
        ln -sf ${f} ~/scripts/$(basename ${f})
    done
}

function remove_files()
{
    for f in ${files[@]}
    do
        rm -f ~/.${f}
    done

    for f in ${scripts[@]}
    do
        rm -f ~/scripts/$(basename ${f})
    done
}


