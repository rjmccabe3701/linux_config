#!/bin/bash

command_exists() {
  local command="$1"
  type "$command" >/dev/null 2>&1
}

#TODO: these really should be a part of the tmux-yank plugin
clipboard_copy_command() {
  if command_exists "xclip"; then
    echo "xclip -i -selection clipboard" # For Linux
  elif command_exists "xsel"; then
    echo "xsel -i --clipboard" # For Linux (fallback -- its slower)
  elif command_exists "putclip"; then
    echo "putclip" #For cygwin
  else
    echo "pbcopy" #For MAC
  fi
}

clipboard_paste_command() {
  if command_exists "xclip"; then
    echo "xclip -o -selection clipboard" #linux
  elif command_exists "xsel"; then
    echo "xsel" #linux (fallback -- its slower)
  elif command_exists "putclip"; then
    echo "getclip" #For cygwin
  else
    echo "pbpaste" #For MAC
  fi
}

#Copy from terminal using the mouse to select
COPY_CMD=$(clipboard_copy_command)
if [ -z "$COPY_CMD" ]; then
  tmux bind-key -T copy-mode-vi "p" "tmux display-message 'Error! copy command not installed'"
else
  #Use "y" to yank selection
  tmux bind-key -T copy-mode-vi y send-keys -X copy-pipe-and-cancel "tmux save-buffer - | ${COPY_CMD}"
  #End mouse drag copies also
  tmux bind-key -T copy-mode-vi MouseDragEnd1Pane send-keys -X copy-pipe-and-cancel "tmux save-buffer - | ${COPY_CMD}"
fi

#Allow pasting from system clipboard
PASTE_CMD=$(clipboard_paste_command)
if [ -z "$PASTE_CMD" ]; then
  tmux bind-key -T prefix ] run "tmux display-message 'Error! paste command not installed'"
else
  tmux bind-key -T root MouseDown3Pane run "tmux set-buffer \"\$(${PASTE_CMD})\" && tmux paste-buffer"
  tmux bind-key -T prefix ] run "tmux set-buffer \"\$(${PASTE_CMD})\" && tmux paste-buffer"
fi
