# dotfiles

## Quick start

```sh
curl -fsLS get.chezmoi.io | sh -s -- init --apply github.com/lqueryvg/dotfiles-new
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

After that, `bw-load` (called from your shell) will add the key to the agent on each new shell session.

### 1Password (API tokens)

```sh
# Load API tokens into the current shell session
op-load
```

`op-load` fetches `GITHUB_PACKAGES_TOKEN`, `JIRA_API_TOKEN`, and `CONFLUENCE_API_TOKEN` from the Employee vault.

---

## Philosophy

- **mise first**: all tools managed by mise where possible
- **Homebrew as last resort**: only when mise has no viable path
- **chezmoi for dotfiles**: templates for machine-specific values; private files use `private_` prefix

---

## Runbook

### Adopt a new dotfile

```sh
mise run adopt ~/.some-config-file
```

### Add a bin script

Drop it in `bin/` at the repo root. It will be on PATH as `~/dotfiles/bin/<script>` after bootstrap.

### Add a new shell tool to dotfile_source

Create `home/dot_config/dotfile_source/third-party/<tool>.sh` and adopt it:

```sh
mise run adopt ~/.config/dotfile_source/third-party/<tool>.sh
```
