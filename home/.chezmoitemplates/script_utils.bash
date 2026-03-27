#!/usr/bin/env bash
# Shared logging helpers — included in all .chezmoiscripts/ via:
#   {{`{{ template "script_utils.bash" . }}`}}

_tput() { tput "$@" 2>/dev/null || true; }

_bold()  { printf '%s' "$(_tput bold)${*}$(_tput sgr0)"; }
_green() { printf '%s' "$(_tput setaf 2)${*}$(_tput sgr0)"; }
_yellow(){ printf '%s' "$(_tput setaf 3)${*}$(_tput sgr0)"; }
_red()   { printf '%s' "$(_tput setaf 1)${*}$(_tput sgr0)"; }

log_info()    { printf '%s\n' "$(_bold "[dotfiles]") ${*}"; }
log_success() { printf '%s\n' "$(_bold "$(_green "[dotfiles ✓]")") ${*}"; }
log_warn()    { printf '%s\n' "$(_bold "$(_yellow "[dotfiles !]")") ${*}" >&2; }
log_error()   { printf '%s\n' "$(_bold "$(_red "[dotfiles ✗]")") ${*}" >&2; }
