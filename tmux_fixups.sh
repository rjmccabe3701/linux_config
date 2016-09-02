#!/bin/bash


command_exists() {
	local command="$1"
	type "$command" >/dev/null 2>&1
}

#TODO: these really should be a part of the tmux-yank plugin
clipboard_copy_command() {
    if command_exists "pbcopy"; then
        echo "pbcopy" #For MAC
    elif command_exists "putclip"; then
        echo "putclip" #For cygwin
    else
        echo ""
    fi
}

#Copy from terminal using the mouse to select
COPY_CMD=$(clipboard_copy_command)
if [ -z "$COPY_CMD" ]; then
	tmux bind-key -t vi-copy "p" "tmux display-message 'Error! copy command not installed'"
else
	#Middle click and <copy-mode>+p will paste the system clipboard
	tmux bind-key -t vi-copy MouseDragEnd1Pane copy-pipe "${COPY_CMD}"
fi

clipboard_paste_command() {
    if command_exists "pbpaste"; then
        echo "pbpaste" #For MAC
    elif command_exists "getclip"; then
        echo "getclip" #For cygwin
    else
        echo ""
    fi
}

#Allow pasting from system clipboard
PASTE_CMD=$(clipboard_paste_command)
if [ -z "$PASTE_CMD" ]; then
	tmux bind-key -t vi-copy "p" "tmux display-message 'Error! paste command not installed'"
else
	tmux bind-key -T root MouseDown3Pane run 'tmux set-buffer "${PASTE_CMD}"; tmux paste-buffer'
	tmux bind-key -T prefix C-v run 'tmux set-buffer "${PASTE_CMD}"; tmux paste-buffer'
fi

