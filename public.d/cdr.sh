is_zsh || return
is_interactive || return

function cdr() {
  cd $(git rev-parse --show-toplevel)
}
