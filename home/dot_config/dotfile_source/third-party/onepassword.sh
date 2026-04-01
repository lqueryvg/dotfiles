command_exists op || return 0

op-load() {
  [[ -n "${OP_SESSION_LOADED:-}" ]] && return 0

  if [[ ! -d "/Applications/1Password.app" ]]; then
    echo "op-load: 1Password app not installed — skipping secret load" >&2
    return 0
  fi

  local vault="Employee"
  local token secret
  local -a tokens=(
    GITHUB_PACKAGES_TOKEN
    JIRA_API_TOKEN
    CONFLUENCE_API_TOKEN
  )

  local failed=0
  for token in "${tokens[@]}"; do
    secret=$(op read "op://${vault}/${token}/credential" 2>/dev/null)
    if [[ -n "$secret" ]]; then
      export "$token=$secret"
    else
      echo "op-load: warning: $token not found in 1Password" >&2
      failed=1
    fi
  done

  [[ $failed -eq 0 ]] && export OP_SESSION_LOADED=1
}
