#!/bin/bash
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

if [ $# -eq 1 ]; then
   if [ ! -d $1 ]; then
      echo "Could not find plugin directory $1" >&2
      exit 1
   fi
   export LINUX_CONFIG_PLUGIN_DIR="$(cd $1 && pwd)"
else
   unset LINUX_CONFIG_PLUGIN_DIR
fi

cd ${DIR}

${DIR}/uninstall.sh
source ${DIR}/functions.sh
install_files

#Install Vim plugins
curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

#Neovim configuration:
# http://vimcasts.org/episodes/meet-neovim/
mkdir -p ~/.config/nvim
cat <<EOF > ~/.config/nvim/init.vim
set runtimepath+=~/.vim,~/.vim/after
set packpath+=~/.vim
source ~/.vimrc
EOF

#Force https git submodules.  See this:
# https://github.com/ycm-core/ycmd/issues/1421
git config --global url."https://".insteadOf git://

#Install neovim plugins
nvim \
    "+PlugInstall" \
    "+PlugClean" \
    "+qall"

#Put gitconfig back to what it was
git checkout dot_files/gitconfig

#Oh-my-zsh
git clone --depth=1 https://github.com/robbyrussell/oh-my-zsh.git ~/.oh-my-zsh
cp ~/.oh-my-zsh/templates/zshrc.zsh-template ~/.zshrc

#TMUX plugin manager
mkdir -p ~/.tmux/plugins
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
#Install tmux plugings
ln -sf ${DIR}/tmux_fixups.sh ~/.tmux/tmux_fixups.sh
~/.tmux/plugins/tpm/scripts/install_plugins.sh

#Don't share history between terminals
echo 'setopt no_share_history' >> ~/.zshrc
echo 'DISABLE_AUTO_UPDATE=true' >> ~/.zshrc
ln -sf ${DIR}/custom.zsh ~/.oh-my-zsh/lib/custom.zsh

IS_WINDOWS=0
case "$(uname -s)" in

   Darwin)
     echo 'Detected MAC'
     echo 'export EDITOR=/usr/local/bin/nvim' >> ~/.zshrc
     ;;

   Linux)
     if echo "$(uname -a)" | grep -q Microsoft; then
        echo 'Detected WSL'
        IS_WINDOWS=1
     else
        echo 'Detected Linux'
     fi
     ;;

   CYGWIN*|MINGW32*|MSYS*)
     echo 'MS Windows'
    {
        #If running in cygwin the git prompt is very slow
        # This should fix it.
        echo -e '[oh-my-zsh]\n\thide-status = 1'
    } >> ~/.gitconfig

    #Cygwin can be slow with zsh depending on the plugin used ...
    # cypher seems to work well.
    #See
    # https://github.com/robbyrussell/oh-my-zsh/issues/4179
    sed -i 's/ZSH_THEME=.*/ZSH_THEME="cypher"/' ${DIR}/custom.zsh
    #This speeds up git on windows a bit
    git config core.fscache true

    echo "To configure your cywgin adcount, add"
    echo "db_home: /home/<username>"
    echo "to your /etc/nsswitch.conf"
    echo "Note that you may have git-related perf issues if you use a /cygdrive directory for home"
    echo "See "
    echo "http://stackoverflow.com/questions/1494658/how-can-i-change-my-cygwin-home-folder-after-installation"
    echo "for more information"

     ;;
esac

if [ $IS_WINDOWS -eq 1 ]; then
   git checkout ${DIR}/dot_files/gitconfig
   echo "applying windows-specific fixups"
   {
      #If running in Windows (WSL or cygwin) the git prompt is very slow
      # This should fix it.
      echo -e '[oh-my-zsh]\n\thide-status = 1'
   } >> ~/.gitconfig

   git checkout ${DIR}/custom.zsh
   #Windows can be slow with zsh depending on the plugin used ...
   # cypher seems to work well.
   #See
   # https://github.com/robbyrussell/oh-my-zsh/issues/4179
   sed -i 's/ZSH_THEME=.*/ZSH_THEME="cypher"/' ${DIR}/custom.zsh

   #This gets rid of the annoying "nice(5) failed ..." errors in zsh:
   #https://evalcode.com/zsh-default-wsl-windows-10/
   echo "unsetopt BG_NICE" >> ${DIR}/custom.zsh
   #This speeds up git on windows a bit
   git config core.fscache true
fi

if [ -f ${LINUX_CONFIG_PLUGIN_DIR}/custom_install.sh ]
then
   ${LINUX_CONFIG_PLUGIN_DIR}/custom_install.sh
fi
env zsh
