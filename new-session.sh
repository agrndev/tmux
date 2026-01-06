#!/bin/bash

if ! command -v fzf &>/dev/null; then
  echo "[Error] fzf is not installed."
  exit 1
fi

if ! command -v tmux &>/dev/null; then
  echo "[Error] TMUX is not installed."
  exit 1
fi

BASE_DIRS=(
  "$HOME/repos/"
  "$HOME/.config/"
)

folders=()
for dir in "${BASE_DIRS[@]}"; do
  if [[ -d "$dir" ]]; then
    while IFS= read -r subdir; do
      folders+=("$subdir")
    done < <(find "$dir" -mindepth 1 -maxdepth 1 -type d)
  fi
done

selected_dir=$(printf "%s\n" "${folders[@]}" | fzf --prompt="Select a folder: ")

if [[ -z "$selected_dir" ]]; then
  echo "No folder selected. Exiting."
  exit 0
fi

session_name=$(basename "$selected_dir")
session_name="${session_name//./_}"

if tmux has-session -t "$session_name" 2>/dev/null; then
  if [[ -n "$TMUX" ]]; then
    tmux switch-client -t "$session_name"
  else
    tmux attach-session -t "$session_name"
  fi
  exit 0
fi

tmux new-session -d -s "$session_name" -c "$selected_dir" -n "editor"
tmux send-keys -t "$session_name":1 "nvim" C-m

tmux new-window -t "$session_name":2 -n "terminal" -c "$selected_dir"

tmux select-window -t "$session_name":1

if [[ -n "$TMUX" ]]; then
  tmux switch-client -t "$session_name"
else
  tmux attach-session -t "$session_name"
fi
