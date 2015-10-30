ZSH_THEME="candy"
plugins=(git colored-man-pages web-search tmux)

# # User configuration
# #MY STUFF
export PATH=$PATH:~/scripts
# #From
# #http://stackoverflow.com/questions/21806168/vim-use-ctrl-q-for-visual-block-mode-in-vim-gnome
stty start undef
# #From
# #http://unix.stackexchange.com/questions/12107/how-to-unfreeze-after-accidentally-pressing-ctrl-s-in-a-terminal
stty -ixon

# # alias tmux='tmux -2'
# TDRS=192.168.141.210
# VM=192.168.75.128

# export MANPATH="/usr/local/man:$MANPATH"

#Disable TMUX windows from re-naming themselves
DISABLE_AUTO_TITLE="true"

