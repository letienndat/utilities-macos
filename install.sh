#!/bin/bash

CONFIG_DIR="$HOME/.hammerspoon"
REPO_DIR="$(pwd)"

echo "installing to: $CONFIG_DIR"
echo "real home: $HOME"
pwd

mkdir -p "$CONFIG_DIR"

shopt -s dotglob nullglob
for item in "$REPO_DIR"/* "$REPO_DIR"/.*; do
    [[ "$(basename "$item")" == "." || "$(basename "$item")" == ".." ]] && continue
    cp -r "$item" "$CONFIG_DIR"/
done
shopt -u dotglob nullglob