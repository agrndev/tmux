#!/usr/bin/env bash

if ! tmux ls >/dev/null 2>&1; then
  echo "No TMUX sessions found."
  exit 1
fi

selected=$(tmux ls -F '#S' | fzf --prompt="Remove session: ")

if [[ -z "$selected" ]]; then
  exit 0
fi

if [[ -n "$TMUX" ]]; then
  current_session=$(tmux display-message -p '#S')
  if [[ "$selected" == "$current_session" ]]; then
    remaining_sessions=$(tmux ls -F '#S' | grep -v "^${selected}$")
    if [[ -n "$remaining_sessions" ]]; then
      tmux switch-client -t "$(echo "$remaining_sessions" | head -n 1)"
    fi
  fi
fi

tmux kill-session -t "$selected"
