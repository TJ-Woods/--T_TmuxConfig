#!/bin/bash

SESSION_1="Main"
SESSION_2="Alt"

WINDOW_1_1="Git"
WINDOW_1_2="Neovim"
WINDOW_2_1="Bash"

# Check if the tmux server is already running any sessions
if tmux has-session 2>/dev/null; then
    exec tmux attach-session
else
    tmux new-session -d -s "$SESSION_1" -n "$WINDOW_1_1"
    tmux new-window -t "$SESSION_1" -n "$WINDOW_1_2"
    tmux new-session -d -s "$SESSION_2" -n "$WINDOW_2_1"

    exec tmux attach-session -t "$SESSION_1"
fi
