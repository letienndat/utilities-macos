#!/bin/bash

set -e

REAL_HOME=$(dscl . -read /Users/$(whoami) NFSHomeDirectory | awk '{print $2}')
CONFIG_DIR="$REAL_HOME/.hammerspoon"
REPO_DIR="$(cd "$(dirname "$0")" && pwd)"

echo "Copying configs to: $CONFIG_DIR"
mkdir -p "$CONFIG_DIR"

if [ ! -d "$REPO_DIR" ]; then
    echo "Repo folder not found: $REPO_DIR"
    exit 1
fi

shopt -s dotglob nullglob
cp -r "$REPO_DIR"/* "$CONFIG_DIR"/
shopt -u dotglob nullglob

echo "Installed to $CONFIG_DIR"