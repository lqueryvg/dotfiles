#!/usr/bin/env bash
set -euo pipefail

if [[ "$OSTYPE" != "darwin"* ]]; then
  echo "Not macOS — skipping macOS defaults"
  exit 0
fi

# ---------------------------------------------------------------------------
# Dock
# ---------------------------------------------------------------------------
defaults write com.apple.dock orientation         -string "left"
defaults write com.apple.dock autohide            -bool true
defaults write com.apple.dock tilesize            -int 40
defaults write com.apple.dock show-recents        -bool false

# ---------------------------------------------------------------------------
# Keyboard
# ---------------------------------------------------------------------------
defaults write NSGlobalDomain KeyRepeat           -int 2
defaults write NSGlobalDomain InitialKeyRepeat    -int 15

# ---------------------------------------------------------------------------
# Finder
# ---------------------------------------------------------------------------
defaults write com.apple.finder AppleShowAllFiles         -bool true
defaults write NSGlobalDomain AppleShowAllExtensions      -bool true

# ---------------------------------------------------------------------------
# Screenshots
# ---------------------------------------------------------------------------
mkdir -p "${HOME}/Desktop/screenshots"
defaults write com.apple.screencapture location   -string "${HOME}/Desktop/screenshots"

# ---------------------------------------------------------------------------
# Restart affected services
# ---------------------------------------------------------------------------
killall Dock
killall Finder
killall SystemUIServer
