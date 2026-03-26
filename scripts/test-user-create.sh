#!/usr/bin/env bash
set -euo pipefail

TEST_USER="dottest"
TEST_HOME="/Users/${TEST_USER}"
TEST_UID=601

if id "${TEST_USER}" &>/dev/null; then
    echo "User ${TEST_USER} already exists. Run scripts/test-user-destroy.sh first."
    exit 1
fi

echo "Creating test user: ${TEST_USER}"
sudo dscl . -create "/Users/${TEST_USER}"
sudo dscl . -create "/Users/${TEST_USER}" UserShell /bin/zsh
sudo dscl . -create "/Users/${TEST_USER}" RealName "Dotfiles Test User"
sudo dscl . -create "/Users/${TEST_USER}" UniqueID "${TEST_UID}"
sudo dscl . -create "/Users/${TEST_USER}" PrimaryGroupID 20
sudo dscl . -create "/Users/${TEST_USER}" NFSHomeDirectory "${TEST_HOME}"
sudo createhomedir -c -u "${TEST_USER}"

echo "Bootstrapping dotfiles as ${TEST_USER}..."
sudo -u "${TEST_USER}" -i bash -c \
    'curl -fsLS get.chezmoi.io | sh -s -- init --apply github/lqueryvg/dotfiles-new'

echo "Done. Test user ${TEST_USER} is ready at ${TEST_HOME}"
echo "Run scripts/test-user-destroy.sh when finished."
