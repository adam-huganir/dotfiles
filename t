#!/bin/bash

CURRENT_DIR=`pwd`
tmux attach -t $1 || tmux new -s $1 -c $CURRENT_DIR
