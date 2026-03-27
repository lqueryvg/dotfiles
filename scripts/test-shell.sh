#!/usr/bin/env zsh
# test-shell.sh — assert dotfiles are working correctly after shell init

pass=0
fail=0

check_alias() {
  if alias "$1" &>/dev/null; then
    print "  ok  alias: $1"
    (( pass++ ))
  else
    print "  FAIL alias: $1"
    (( fail++ ))
  fi
}

check_function() {
  if typeset -f "$1" &>/dev/null; then
    print "  ok  function: $1"
    (( pass++ ))
  else
    print "  FAIL function: $1"
    (( fail++ ))
  fi
}

check_env() {
  if [[ -n "${(P)1}" ]]; then
    print "  ok  env: $1=${(P)1}"
    (( pass++ ))
  else
    print "  FAIL env: $1 (not set or empty)"
    (( fail++ ))
  fi
}

check_path() {
  if (( ${path[(I)$1]} )); then
    print "  ok  PATH contains: $1"
    (( pass++ ))
  else
    print "  FAIL PATH missing: $1"
    (( fail++ ))
  fi
}

check_file() {
  if [[ -e "$1" ]]; then
    print "  ok  file: $1"
    (( pass++ ))
  else
    print "  FAIL file missing: $1"
    (( fail++ ))
  fi
}

check_dir() {
  if [[ -d "$1" ]]; then
    print "  ok  dir: $1"
    (( pass++ ))
  else
    print "  FAIL dir missing: $1"
    (( fail++ ))
  fi
}

# --- Deployed files ---
print "==> Checking deployed files"
check_file "$HOME/.zshrc"
check_file "$HOME/.gitconfig"
check_file "$HOME/.vimrc"
check_file "$HOME/.bashrc"
check_file "$HOME/.inputrc"
check_file "$HOME/.tool-versions"
check_dir  "$HOME/.config/dotfile_source"
check_dir  "$HOME/.config/dotfile_source/third-party"

# --- Aliases ---
print "\n==> Checking aliases"
check_alias rm
check_alias cp
check_alias mv
check_alias grep
check_alias df
check_alias du
check_alias less
check_alias h

# --- Functions ---
print "\n==> Checking functions"
check_function command_exists
check_function source_if_exists
check_function title
check_function sit
check_function yellow

# --- Environment variables ---
print "\n==> Checking environment variables"
check_env EDITOR
check_env VISUAL
check_env PAGER
check_env XDG_CONFIG_HOME
check_env XDG_DATA_HOME
check_env XDG_CACHE_HOME
check_env XDG_STATE_HOME

# --- PATH ---
print "\n==> Checking PATH"
check_path "$HOME/.local/bin"

print ""
if (( fail == 0 )); then
  print "All $pass checks passed."
else
  print "$fail/$((pass + fail)) checks FAILED."
  exit 1
fi
