#!/usr/bin/env bash

tmux ls >/dev/null 2>&1 || {
  echo "No TMUX sessions found."
  exit 1
}

session=$(tmux ls -F '#S' | fzf --prompt="Load session: ")

if [ -n "$session" ]; then
  tmux attach -t "$session"
fi
