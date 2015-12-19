#!/bin/bash
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
source ${DIR}/functions.sh
install_files
pushd ~
# curl http://j.mp/spf13-vim3 -L -o - | sh
# sh -c "$(curl -fsSL https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
rm -rf ~/.oh-my-zsh
rm -rf ~/.zshrc
git clone --depth=1 https://github.com/robbyrussell/oh-my-zsh.git ~/.oh-my-zsh
cp ~/.oh-my-zsh/templates/zshrc.zsh-template ~/.zshrc
#Don't share history between terminals
echo 'setopt no_share_history' >> ~/.zshrc
popd
ln -sf ${DIR}/custom.zsh ~/.oh-my-zsh/lib/custom.zsh


case "$(uname -s)" in

   Darwin)
     echo 'Detected MAC'
     ;;

   Linux)
     echo 'Detected Linux'
     ;;

   CYGWIN*|MINGW32*|MSYS*)
     echo 'MS Windows'
    # This should fix it.
    #If running in cygwin the git prompt is very slow
    # This should fix it.
    echo -e '[oh-my-zsh]\n\thide-status = 1' >> ~/.gitconfig
     ;;
esac

env zsh



