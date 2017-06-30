ZSH_THEME="candy"
# plugins=(git colored-man-pages web-search tmux vi-mode scd)
plugins=(git colored-man-pages web-search tmux vi-mode)

# # User configuration
# #MY STUFF
export PATH=~/scripts:~/usr/bin:~/usr/sbin/:$PATH
export LD_LIBRARY_PATH=~/usr/lib:${LD_LIBRARY_PATH}
export MANPATH=~/usr/share/man:${MANPATH}

#Smart change directory
# alias s=scd
if [ -e /usr/share/autojump/autojump.zsh ]; then
   source  /usr/share/autojump/autojump.zsh
fi

# #From
# #http://stackoverflow.com/questions/21806168/vim-use-ctrl-q-for-visual-block-mode-in-vim-gnome
stty start undef
# #From
# #http://unix.stackexchange.com/questions/12107/how-to-unfreeze-after-accidentally-pressing-ctrl-s-in-a-terminal
stty -ixon

#Disable TMUX windows from re-naming themselves
DISABLE_AUTO_TITLE="true"

#Looks like Control-R (reverse search is disabled by default in vi-mode) ...
bindkey -v
bindkey '^R' history-incremental-search-backward
bindkey '^F' history-incremental-search-forward
bindkey '^A' beginning-of-line
bindkey '^E' end-of-line

if [[ -e ~/.myzshrc ]]; then
   . ~/.myzshrc
fi
