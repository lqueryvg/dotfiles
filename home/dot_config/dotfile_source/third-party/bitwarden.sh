# bw-load: add SSH key to agent (skips if already loaded)
bw-load() {
  local key="$HOME/.ssh/lqueryvg-github"
  [[ -f "$key" ]] || { echo "bw-load: $key not found — run bw-setup first" >&2; return 1; }
  ssh-add -l 2>/dev/null | grep -q "$key" && return 0
  ssh-add "$key"
}

# bw-setup: one-time interactive setup — fetches SSH key from Bitwarden and writes it to disk
bw-setup() {
  command_exists bw || { echo "bw-setup: bw not found — run: mise install" >&2; return 1; }

  local key="$HOME/.ssh/lqueryvg-github"
  if [[ -f "$key" ]]; then
    echo "bw-setup: $key already exists, skipping"
    return 0
  fi

  echo "bw-setup: unlocking Bitwarden..."
  local session
  session=$(bw unlock --raw) || { echo "bw-setup: unlock failed" >&2; return 1; }

  local private_key
  private_key=$(BW_SESSION="$session" bw get item "lqueryvg-github" | jq -r '.notes') \
    || { echo "bw-setup: failed to retrieve key" >&2; return 1; }

  mkdir -p "$HOME/.ssh"
  chmod 700 "$HOME/.ssh"
  printf '%s\n' "$private_key" > "$key"
  chmod 600 "$key"
  echo "bw-setup: key written to $key"
  ssh-add "$key"
}
