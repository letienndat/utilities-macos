#!/bin/bash

CONFIG_DIR="$HOME/.hammerspoon"
REPO_DIR="$(pwd)"
CELLAR_DIR="$1"

mkdir -p "$CONFIG_DIR"

shopt -s dotglob nullglob
for item in "$REPO_DIR"/* "$REPO_DIR"/.*; do
    [[ "$(basename "$item")" == "." || "$(basename "$item")" == ".." ]] && continue
    cp -r "$item" "$CONFIG_DIR"/
done
shopt -u dotglob nullglob

if [[ -n "$CELLAR_DIR" && -d "$CELLAR_DIR" ]]; then
    echo "Utilities copied to $CONFIG_DIR" > "$CELLAR_DIR/README.txt"
else
    echo "⚠️ Warning: Invalid prefix path, skipping README copy"
fi

echo "✅ Copied all contents to $CONFIG_DIR"