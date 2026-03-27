#!/usr/bin/env bash
# test-brew.sh — assert that key Brewfile packages are installed

pass=0
fail=0

check_formula() {
  if brew list --formula "$1" &>/dev/null; then
    echo "  ok  brew: $1"
    (( pass++ ))
  else
    echo "  FAIL brew: $1"
    (( fail++ ))
  fi
}

check_cask() {
  if brew list --cask "$1" &>/dev/null; then
    echo "  ok  cask: $1"
    (( pass++ ))
  else
    echo "  FAIL cask: $1"
    (( fail++ ))
  fi
}

echo "==> Checking Homebrew formulae"
check_formula ripgrep
check_formula tree
check_formula zoxide
check_formula coreutils
check_formula gnupg
check_formula docker

echo "==> Checking Homebrew casks"
check_cask 1password-cli

echo ""
if (( fail == 0 )); then
  echo "All $pass checks passed."
else
  echo "$fail/$((pass + fail)) checks FAILED."
  exit 1
fi
