#!/usr/bin/env bash

if ! tmux ls >/dev/null 2>&1; then
  echo "No TMUX sessions found."
  exit 1
fi

session=$(tmux ls -F '#S' | fzf --prompt="Load session: ")

if [ -n "$session" ]; then
  if [ -n "$TMUX" ]; then
    tmux switch-client -t "$session"
  else
    tmux attach-session -t "$session"
  fi
fi
