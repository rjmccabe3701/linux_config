ZSH_THEME="candy"
# plugins=(git colored-man-pages web-search tmux vi-mode scd)
plugins=(git colored-man-pages web-search tmux vi-mode \
   copybuffer copyfile copydir kubectl)

#Smart change directory
# alias s=scd
if [ -e /usr/share/autojump/autojump.zsh ]; then
   source  /usr/share/autojump/autojump.zsh
elif [ -e /usr/local/share/autojump/autojump.zsh  ]; then
   source  /usr/local/share/autojump/autojump.zsh
elif [ -e /home/$USER/.autojump/share/autojump/autojump.zsh  ]; then
   #This is where the install for
   # https://github.com/wting/autojump
   #will put it
   source /home/$USER/.autojump/share/autojump/autojump.zsh
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

#Fix the Home/End/Delete keys from
# https://blog.rabin.io/quick-tip/zsh-home-end-keys
bindkey '\e[1~'   beginning-of-line  # Linux console
bindkey '\e[H'    beginning-of-line  # xterm
bindkey '\eOH'    beginning-of-line  # gnome-terminal
bindkey '\e[2~'   overwrite-mode     # Linux console, xterm, gnome-terminal
bindkey '\e[3~'   delete-char        # Linux console, xterm, gnome-terminal
bindkey '\e[4~'   end-of-line        # Linux console
bindkey '\e[F'    end-of-line        # xterm
bindkey '\eOF'    end-of-line        # gnome-terminal


if [[ -e ~/.myzshrc ]]; then
   . ~/.myzshrc
fi
