#!/usr/bin/env zsh
# test-shell.sh — assert that key aliases and functions are defined after shell init

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
    print "  ok  env: $1"
    (( pass++ ))
  else
    print "  FAIL env: $1"
    (( fail++ ))
  fi
}

print "==> Checking aliases"
check_alias ls
check_alias grep
check_alias mv
check_alias cp
check_alias rm

print "==> Checking functions"
check_function command_exists
check_function source_if_exists
check_function title

print "==> Checking env vars"
check_env XDG_CONFIG_HOME
check_env EDITOR
check_env SHELL

print ""
if (( fail == 0 )); then
  print "All $pass checks passed."
else
  print "$fail/$((pass + fail)) checks FAILED."
  exit 1
fi
