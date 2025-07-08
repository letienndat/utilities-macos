#!/bin/bash

set -e

REAL_HOME=$(dscl . -read /Users/$(whoami) NFSHomeDirectory | awk '{print $2}')
CONFIG_DIR="$REAL_HOME/.hammerspoon"
REPO_DIR="$(cd "$(dirname "$0")" && pwd)"

echo "Copying selected configs to: $CONFIG_DIR"

mkdir -p "$CONFIG_DIR"

TARGETS=("features" "features.lua" "init.lua")

for item in "${TARGETS[@]}"; do
    if [ -e "$REPO_DIR/$item" ]; then
        echo "→ Copying $item"
        cp -R "$REPO_DIR/$item" "$CONFIG_DIR/"
    else
        echo "Skipped missing: $item"
    fi
done

echo "Done copying to $CONFIG_DIR"