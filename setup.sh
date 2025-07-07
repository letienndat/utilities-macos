#!/bin/bash

echo "🔧 Setting up Hammerspoon config..."

if [ ! -d "$HOME/.hammerspoon" ]; then
  mkdir "$HOME/.hammerspoon"
fi

cp -r ./* "$HOME/.hammerspoon/"

echo "✅ Copied config to ~/.hammerspoon"
echo "📢 Open Hammerspoon and click 'Reload Config'"