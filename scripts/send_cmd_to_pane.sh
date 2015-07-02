#!/bin/bash


if [ -z "$1" ]
then
	echo "must enter a cmd"
	exit 1
fi

cmd=$1

if [ -z "$2" ]
then
	echo "must enter a pane number"
	exit 1
fi
pane=$2


ORIG_PANE_INDEX=`tmux display-message -p '#P'`
tmux select-pane -t $pane
tmux send-keys "$cmd" C-m

tmux select-pane -t $ORIG_PANE_INDEX
