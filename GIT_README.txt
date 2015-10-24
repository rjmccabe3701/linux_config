This system uses GIT to manage its home directory configuration.  It follows the idea from here:

https://www.digitalocean.com/community/tutorials/how-to-use-git-to-manage-your-user-configuration-files-on-a-linux-vps

To add another file/folder to version control you will need to do:

> git add -f <new_file/folder>

Then git push origin master

To synchronize changes to another computer do:

cd ~
git init
git remote add origin https://github.com/rjmccabe3701/linux_config.git
git fetch --all
git reset --hard origin/master


----------- VIM -----------------
I am using the spf13 "distribution" for VIM.  See http://vim.spf13.com/
To install just do:

curl http://j.mp/spf13-vim3 -L -o - | sh

----------- ZSH -----------------
I am using the oh-my-zsh "distribution" for zsh.  See https://github.com/robbyrussell/oh-my-zsh
To install just do:

sh -c "$(curl -fsSL https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"

To upgrade do

upgrade_oh_my_zsh

(it should also autoupdate every few weeks).
