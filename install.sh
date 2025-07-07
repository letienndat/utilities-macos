#!/bin/bash

CONFIG_DIR="$HOME/.hammerspoon"
REPO_DIR="$(pwd)"
CELLAR_DIR="$1"

mkdir -p "$CONFIG_DIR"

mv "$REPO_DIR"/* "$CONFIG_DIR"/ 2>/dev/null
mv "$REPO_DIR"/.* "$CONFIG_DIR"/ 2>/dev/null || true

if [[ -n "$CELLAR_DIR" && -d "$CELLAR_DIR" ]]; then
    echo "Utilities moved to $CONFIG_DIR" > "$CELLAR_DIR/README.txt"
else
    echo "Warning: Invalid prefix path, skipping README copy"
fi

echo "Moved all contents to $CONFIG_DIR"
