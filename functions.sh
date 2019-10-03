#!/bin/bash
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

files=(gitconfig vimrc)
scripts=$(find ${DIR}/scripts -type f)

function install_files()
{
   tmux_version=$(tmux -V | cut -c 6- | sed 's/[a-z]//g')
   if [[ $(echo "$tmux_version >= 2.9" | bc) -eq 1 ]] ; then
      ln -sf ${DIR}/tmux.conf ~/.tmux.conf
   else
      ln -sf ${DIR}/tmux_pre2_9.conf ~/.tmux.conf
   fi
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


