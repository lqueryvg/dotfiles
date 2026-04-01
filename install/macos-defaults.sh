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
# Restart affected services (excluding Dock — restarting it disrupts dynamic
# app registrations such as Firefox profile dock entries)
# ---------------------------------------------------------------------------
killall Finder 2>/dev/null || true
killall SystemUIServer 2>/dev/null || true
