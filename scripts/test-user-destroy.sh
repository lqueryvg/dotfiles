#!/usr/bin/env bash
set -euo pipefail

TEST_USER="dottest"
TEST_HOME="/Users/${TEST_USER}"

if ! id "${TEST_USER}" &>/dev/null; then
    echo "User ${TEST_USER} does not exist. Nothing to do."
    exit 0
fi

echo "Removing test user: ${TEST_USER}"
sudo dscl . -delete "/Users/${TEST_USER}"
sudo rm -rf "${TEST_HOME}"

echo "Done. ${TEST_USER} removed."
