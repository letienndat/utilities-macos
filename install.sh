#!/bin/bash

if [[ "$OSTYPE" == "darwin"* ]]; then
    REAL_HOME=$(dscl . -read /Users/$(whoami) NFSHomeDirectory | awk '{print $2}')
else
    REAL_HOME=$(getent passwd $(whoami) | cut -d: -f6)
fi

CONFIG_DIR="$REAL_HOME/.hammerspoon"
REPO_DIR="$(pwd)"

echo "installing to: $CONFIG_DIR"
echo "real home: $REAL_HOME"
echo "repo dir: $REPO_DIR"

mkdir -p "$CONFIG_DIR"

shopt -s dotglob nullglob
for item in "$REPO_DIR"/* "$REPO_DIR"/.*; do
    [[ "$(basename "$item")" == "." || "$(basename "$item")" == ".." ]] && continue
    cp -r "$item" "$CONFIG_DIR"/
done
shopt -u dotglob nullglob