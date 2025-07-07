#!/bin/bash

CONFIG_DIR="$HOME/.hammerspoon"
REPO_DIR="$(pwd)"

mkdir -p "$CONFIG_DIR"

cp -r "$REPO_DIR/features" "$CONFIG_DIR/"
cp "$REPO_DIR/init.lua" "$CONFIG_DIR/init.lua"

echo "Copied config to $CONFIG_DIR"