#!/bin/bash

SESSION_1="Main"
WINDOW_1_1="Git"
WINDOW_1_2="Neovim"

SESSION_2="Alt"
WINDOW_2_1="Bash"


# Check if the tmux server is already running any sessions
if tmux has-session 2>/dev/null; then
    exec tmux attach-session
else
    tmux new-session -d -s "$SESSION_1" -n "$WINDOW_1_1" -c "$1"
    tmux split-window -h -l 66 -t "$WINDOW_1_1" -c "$1"
    if [[ $# -gt 0 ]]; then
        tmux new-window -n "$WINDOW_1_2" -t "$SESSION_1" -c "$1" "command -v nvim >/dev/null && nvim .|| vim .; exec $SHELL"
    else
        tmux new-window -n "$WINDOW_1_2" -t "$SESSION_1"
    fi
    tmux new-session -d -s "$SESSION_2" -n "$WINDOW_2_1" -c "$1"
    exec tmux attach-session -t "$SESSION_1"
fi
