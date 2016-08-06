#!/bin/bash


command_exists() {
	local command="$1"
	type "$command" >/dev/null 2>&1
}

#TODO: these really should be a part of the tmux-yank plugin

#Allow pasting from system clipboard
if command_exists "getclip"; then
	#Middle click and <prefix>+C-v will paste the system clipboard
	tmux bind-key -T root MouseDown2Pane run 'tmux set-buffer "$(getclip)"; tmux paste-buffer'
	tmux bind-key -T prefix C-v run 'tmux set-buffer "$(getclip)"; tmux paste-buffer'
else
	tmux bind-key -t vi-copy "p" "tmux display-message 'Error! getclip not installed'"
fi

#Copy from terminal using the mouse to select
if command_exists "putclip"; then
	#Middle click and <copy-mode>+p will paste the system clipboard
	tmux bind-key -t vi-copy MouseDragEnd1Pane copy-pipe "putclip"
else
	tmux bind-key -t vi-copy "p" "tmux display-message 'Error! putclip not installed'"
fi

