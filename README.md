# dotfiles

## Quick start

```sh
curl -fsLS get.chezmoi.io | sh -s -- -b ~/.local/bin init --apply github.com/lqueryvg/dotfiles-new
```

---

## Post-bootstrap manual steps

These steps require interactive authentication and cannot be automated.

### Bitwarden (SSH key)

Run once after first bootstrap on a new machine:

```sh
# 1. Log in (requires email OTP on new devices)
bw login lqueryvg@gmail.com

# 2. Fetch SSH key from Bitwarden vault and install to ~/.ssh/lqueryvg-github
bw-setup
```

`bw-setup` will:
- Prompt for your master password to unlock the vault
- Write the private key to `~/.ssh/lqueryvg-github` (mode 600)
- Add it to the SSH agent

After a machine restart, run `bw-load` to re-add the key to the agent. The SSH agent is shared across all terminal sessions for your user, so one call per boot is enough.

### 1Password (API tokens)

```sh
# Load API tokens into the current shell session
op-load
```

Fetches API tokens from the 1Password Employee vault and exports them as env vars. Env vars are scoped to the current shell process — run `op-load` in each terminal that needs them. Re-runs are skipped automatically once loaded; call again if any token failed (e.g. session expired).

---

## Philosophy

- **mise first**: all tools managed by mise where possible
- **Homebrew as last resort**: only when mise has no viable path
- **chezmoi for dotfiles**: templates for machine-specific values; private files use `private_` prefix

---

## Runbook

### Test that dotfiles are working

```sh
mise run test
# or directly:
zsh -i ~/.local/share/chezmoi/scripts/test-shell.sh
```

Checks deployed files, aliases, functions, env vars, and PATH.

### Pull latest dotfiles on an existing machine

```sh
chezmoi update
```

Pulls from GitHub and applies changes. Equivalent to `git pull` + `chezmoi apply`.

### Adopt a new dotfile

```sh
mise run adopt ~/.some-config-file
```

### Add a bin script

Drop it in `bin/` at the repo root. It is immediately on PATH for the current machine. Commit and push to make it available on other machines after `mise run pull`.

### Add a new shell tool to dotfile_source

Create `home/dot_config/dotfile_source/third-party/<tool>.sh`, then adopt it:

```sh
mise run adopt ~/.config/dotfile_source/third-party/<tool>.sh
```
