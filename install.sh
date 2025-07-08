#!/bin/bash

REAL_HOME=$(dscl . -read /Users/$(whoami) NFSHomeDirectory | awk '{print $2}')
CONFIG_DIR="$REAL_HOME/.hammerspoon"
REPO_DIR="/opt/homebrew/Cellar/utilities-macos/1.0.13"

echo "Copying configs to: $CONFIG_DIR"
mkdir -p "$CONFIG_DIR"

shopt -s dotglob nullglob
cp -r "$REPO_DIR"/* "$CONFIG_DIR"/
shopt -u dotglob nullglob

echo "✅ Installed to $CONFIG_DIR"