#!/bin/bash

if [ -f /mnt/c/Windows/System32/clip.exe ]; then
	tee >(/mnt/c/Windows/System32/clip.exe) | tmux load-buffer -
else
	echo "nvimCopy.sh not implemented for your platform" >&2
fi
