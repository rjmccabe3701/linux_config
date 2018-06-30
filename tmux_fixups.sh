#!/bin/bash


command_exists() {
   local command="$1"
   type "$command" >/dev/null 2>&1
}

#TODO: these really should be a part of the tmux-yank plugin
clipboard_copy_command() {
    if command_exists "xsel"; then
        echo "xsel -i --clipboard" # For Linux
    elif command_exists "putclip"; then
        echo "putclip" #For cygwin
    else
        echo "pbcopy" #For MAC
    fi
}

#Copy from terminal using the mouse to select
COPY_CMD=$(clipboard_copy_command)
if [ -z "$COPY_CMD" ]; then
   tmux bind-key -T copy-mode-vi "p" "tmux display-message 'Error! copy command not installed'"
else
   #End mouse drag and <Alt-y> will copy to system clipboard
   tmux bind-key -T copy-mode-vi MouseDragEnd1Pane send-keys -X copy-pipe-and-cancel "${COPY_CMD}"
   # tmux bind-key -T copy-mode-vi M-y send-keys -X copy-pipe-and-cancel "${COPY_CMD}"
   tmux bind-key -T copy-mode-vi y send-keys -X copy-pipe-and-cancel "${COPY_CMD}"
fi

#Allow pasting from system clipboard
if command_exists "xsel"; then
    #For Linux
    tmux bind-key -T root MouseDown3Pane run 'tmux set-buffer "$(xsel)"; tmux paste-buffer'
    tmux bind-key -T prefix ] run 'tmux set-buffer "$(xsel)"; tmux paste-buffer'
elif command_exists "getclip"; then
    #For cygwin
    tmux bind-key -T root MouseDown3Pane run 'tmux set-buffer "$(getclip)"; tmux paste-buffer'
    tmux bind-key -T prefix ] run 'tmux set-buffer "$(getclip)"; tmux paste-buffer'
elif command_exists "pbpaste"; then
    #For MAC
    tmux bind-key -T root MouseDown3Pane run 'tmux set-buffer "$(pbpaste)"; tmux paste-buffer'
    tmux bind-key -T prefix ] run 'tmux set-buffer "$(pbpaste)"; tmux paste-buffer'
else
    tmux bind-key -T prefix ] run "tmux display-message 'Error! paste command not installed'"
fi

