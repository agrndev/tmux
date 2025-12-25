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
  "$HOME/work/"
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

read -p "session name: " session_name
if [[ -z "$session_name" ]]; then
    echo "Session name cannot be empty. Exiting."
    exit 1
fi

tmux new-session -d -s "$session_name" -c "$selected_dir"
tmux attach-session -t "$session_name"
