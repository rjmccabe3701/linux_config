#!/bin/bash
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
./uninstall.sh
mkdir -p ~/.vim/bundle
source ${DIR}/functions.sh
install_files
pushd ~

#Install Vim plugins
git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
#Install vundle plugins
yes | vim \
    "+set nomore" \
    "+BundleInstall!" \
    "+BundleClean" \
    "+qall"

#Neovim configuration:
# http://vimcasts.org/episodes/meet-neovim/
mkdir -p ~/.config/nvim
cat <<EOF > ~/.config/nvim/init.vim
set runtimepath+=~/.vim,~/.vim/after
set packpath+=~/.vim
source ~/.vimrc
EOF

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
popd
ln -sf ${DIR}/custom.zsh ~/.oh-my-zsh/lib/custom.zsh


case "$(uname -s)" in

   Darwin)
     echo 'Detected MAC'
     echo 'export EDITOR=/usr/local/bin/vim' >> ~/.zshrc
     ;;

   Linux)
     echo 'Detected Linux'
     ;;

   CYGWIN*|MINGW32*|MSYS*)
     echo 'MS Windows'
    {
        #If running in cygwin the git prompt is very slow
        # This should fix it.
        echo -e '[oh-my-zsh]\n\thide-status = 1'
        #Add beyond compare as the default diff and merge tool
        echo -en '[difftool "bc3"]\n\tcmd = \"c:/Program Files/Beyond Compare 3/BCompare.exe\"'
        echo -e ' "$(cygpath -w $LOCAL)" "$(cygpath -w $REMOTE)"'
        echo -en '[mergetool "bc3"]\n\tcmd = \"c:/Program Files/Beyond Compare 3/BCompare.exe\"'
        echo -en  ' "$(cygpath -w $LOCAL)" "$(cygpath -w $REMOTE)"'
        echo -e  ' "$(cygpath -w $BASE)" /mergeoutput="$(cygpath -w $MERGED)"'
    } >> ~/.gitconfig

    #Cygwin can be slow with zsh depending on the plugin used ...
    # cypher seems to work well.
    #See
    # https://github.com/robbyrussell/oh-my-zsh/issues/4179
    sed -i 's/ZSH_THEME=.*/ZSH_THEME="cypher"/' ${DIR}/custom.zsh
    #This speeds up git on windows a bit
    git config core.fscache true

    #See https://github.com/tmux-plugins/tmux-yank/issues/91#issuecomment-306174136
    sed -i '/clip.exe/ d' ~/.tmux/plugins/tmux-yank/scripts/helpers.sh



    echo "To configure your cywgin adcount, add"
    echo "db_home: /home/<username>"
    echo "to your /etc/nsswitch.conf"
    echo "Note that you may have git-related perf issues if you use a /cygdrive directory for home"
    echo "See "
    echo "http://stackoverflow.com/questions/1494658/how-can-i-change-my-cygwin-home-folder-after-installation"
    echo "for more information"

     ;;
esac

env zsh



