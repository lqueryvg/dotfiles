# Dotfiles — Tasks

## Stage 1: Repo skeleton & working bootstrap


- [x] 1.1 Create repo structure: `mise.toml` (with all tasks), `Brewfile` (empty), `.chezmoiroot`, `install/`, `home/`, `scripts/`
- [x] 1.2 Write `home/.chezmoi.toml.tmpl` — hardcoded `name` and `gitEmail`; derives `is_ci_workflow` from `$CI` env var; `[add] secrets = "error"`
- [x] 1.3 Write `home/.chezmoitemplates/script_utils.bash` — shared logging helpers (`log_info`, `log_success`, `log_warn`, `log_error`) included in all `.chezmoiscripts/`
- [x] 1.4 Write minimal `home/dot_zshrc.tmpl` — just the `dotfile_source/` sourcing loop (`find -maxdepth 2 | sort`) + `private.d/` + `~/.dotfiles.local`; no tool config yet
- [x] 1.5 Create `home/dot_config/dotfile_source/.keep` so the directory is tracked
- [x] 1.6 Write `scripts/test-user-create.sh` and `scripts/test-user-destroy.sh`
- [x] 1.7 Push to GitHub as `dotfiles-new` (new public repo under `lqueryvg`)
- [x] 1.8 **Demo**: create test user, run `curl -fsLS get.chezmoi.io | sh -s -- init --apply github.com/lqueryvg/dotfiles-new` as that user, verify `~/.zshrc` exists and contains the sourcing loop; tear down test user

---

## Stage 2: Shell config migration


> ⚠️ **DISRUPTIVE STAGE** — tasks in this stage modify your live shell config (`~/.zshrc`, `~/.config/dotfile_source/`, `~/dotfiles/public.d/`). Run `chezmoi apply` and remove old scripts one at a time. Open a new shell to verify after each apply before proceeding.

- [x] 2.1 Update `home/dot_zshrc.tmpl` with dual-sourcing: source `~/dotfiles/my_zshrc.sh` (old) AND `~/.config/dotfile_source/` (new) — old block removed when migration completes
- [x] 2.2 Set up `dotfile_source/` structure with numbered first-party files:
  - `000-xdg.sh.tmpl` — XDG env vars
  - `010-path.sh.tmpl` — PATH setup
  - `020-exports.sh.tmpl` — env var exports
  - `030-aliases.sh.tmpl` — common aliases
  - `040-functions.sh.tmpl` — shell functions
  - `050-zsh.sh.tmpl` — zsh options, history, completion, keybindings
  - `080-macos.sh.tmpl` — macOS-specific (gated `{{ if eq .chezmoi.os "darwin" }}`)
  - `080-linux.sh.tmpl` — Linux-specific (gated `{{ if eq .chezmoi.os "linux" }}`)
- [x] 2.3 Create `home/dot_config/dotfile_source/third-party/` — one `.sh` file per tool, migrated from `~/dotfiles/public.d/`:
  - `mise.sh`, `aws.sh`, `aws_profiles.sh`, `git.sh`, `go.sh`, `pyenv.sh`, `pnpm.sh`
  - `bat.sh`, `ripgrep.sh`, `zoxide.sh`, `fzf.sh`
  - `brew.sh`, `gcloud.sh`, `terraform.sh`
  - `aliases.sh`, `cdpath.sh`, `ssh.sh`, `vscode.sh`
  - remaining scripts from `~/dotfiles/public.d/`
- [x] 2.4 For each migrated script: remove it from `~/dotfiles/public.d/` so it's only sourced from the new location
- [x] 2.4a Migrate remaining `~/dotfiles/public.d/` deferred scripts (`0_p10k.sh`, `zinit.sh`, `zsh.sh`) to `dotfile_source/` using `zsh_unplugged`; remove from `public.d/`; verify new shell opens with `$? = 0`
- [x] 2.5 Add `~/private.d/` to root `.gitignore`; document the pattern (any `.sh` file in `~/private.d/` is sourced after `dotfile_source/`)
- [x] 2.6 Add `~/.dotfiles.local` sourcing at end of `.zshrc` — machine-specific escape hatch, never committed
- [x] 2.7 `mise run adopt` the `.zshrc` and all `dotfile_source/` files into chezmoi
- [x] 2.7a Write `scripts/test-shell.sh` — sources `.zshrc` in a subshell and asserts that key aliases and functions are defined; exits non-zero on any failure; add `mise run test-shell` task that runs it
- [x] 2.8 **Demo**: (1) open a new shell — confirm `$?=0` and p10k prompt shows; (2) run `mise run test-shell` locally; (3) push all changes to GitHub, then run `mise run test-user-create` and run `mise run test-shell` as the test user — confirm fresh bootstrap works with `dotfile_source/` as sole shell config source; tear down test user

---

## Stage 3: Git config


> ⚠️ **DISRUPTIVE** — `chezmoi apply` will overwrite `~/.gitconfig`. Back up first: `cp ~/.gitconfig ~/.gitconfig.bak`

- [x] 3.1 Write `home/dot_gitconfig.tmpl` — templated `[user]` block using `{{ .name }}` and `{{ .gitEmail }}`; includes `~/.config/git/public.config`; `[includeIf]` for private machine overrides at `~/.config/git/private.config`
- [x] 3.2 Move git public config into `home/dot_config/git/public.config` (included from `.gitconfig.tmpl`)
- [x] 3.3 Remove `.gitconfig` from `~/dotfiles/home_links`
- [x] 3.4 `chezmoi apply` — `~/.gitconfig` is now a real file (not symlink); identity and aliases verified
- [x] 3.5 **Demo**: run `git config user.email` — confirm correct identity; confirm git aliases work; push and run `mise run test-user-create` + `mise run test-shell` as test user; tear down test user

---

## Stage 4: Editor & remaining home files


- [x] 4.1 Migrate `home/dot_vimrc` via `mise run adopt ~/.vimrc`
- [x] 4.2 Write `install/vim-plugins.sh` (installs Vundle + runs `:PluginInstall`); add `home/.chezmoiscripts/run_once_20-vim-plugins.sh.tmpl` as thin wrapper; skipped in CI
- [x] 4.3 Migrate remaining macOS-relevant `home_links` entries: `.inputrc`, `.terraformrc`, `.tool-versions`, `.bashrc`, `.bash_profile`, `.pystartup`, `.bcrc`; Linux/X11/Haskell/tmux entries left as-is (out of scope); `.my_profile.sh` dropped (superseded by Stage 2); `.liquidpromptrc` dropped (replaced by p10k)
- [x] 4.4 Remove migrated entries from `~/dotfiles/home_links`; remaining entries are Linux/X11/Haskell only
- [x] 4.5 **Demo**: open vim, confirm it loads; confirm migrated files present in `~`; push and run `mise run demo`; tear down test user

---

## Stage 5: Bin scripts


- [x] 5.1 Copy `~/dotfiles/bin/` scripts into `bin/` at the root of the new repo
- [x] 5.2 Ensure `home/dot_config/dotfile_source/010-path.sh.tmpl` adds `~/dotfiles/bin` to PATH
- [x] 5.3 **Demo**:
  1. Run `mise run test-user-create` (requires sudo password)
  2. Run `sudo -u dottest -i zsh -c 'which jgr && which gi && which vdiff'`
     - All three should resolve to `/Users/dottest/dotfiles/bin/<script>`
  3. Run `mise run test-user-destroy` (requires sudo password)
  - Note: the current machine can't verify this because `~/dotfiles` still points to the old repo; the test user is the only way to confirm before Stage 10 cutover

---

## Stage 6: Tool installation (Brewfile)


- [x] 6.1 Generate `Brewfile` from current installs: `brew bundle dump --describe --force`
- [x] 6.2 Curate the Brewfile — remove noise, annotate each entry
- [x] 6.3 Write `install/brew.sh` — installs Homebrew if missing, runs `brew bundle install`, sets `HOMEBREW_FORBIDDEN_FORMULAE`
- [x] 6.4 Write `home/.chezmoiscripts/run_onchange_10-brew-packages.sh.tmpl` — calls `install/brew.sh`; hash comment triggers re-run when Brewfile changes; gated on `{{ if not .is_ci_workflow }}`
- [x] 6.5 Add `scripts/test-brew.sh` — asserts key Brewfile packages are installed; add `mise run test-brew` task; wire into `mise run demo`
- [x] 6.6 **Demo**:
  1. Run `mise run demo`
     - Creates test user, bootstraps dotfiles, runs `test-shell` and `test-brew` as test user, tears down
  2. Confirm `test-brew` reports all checks passed

---

## Stage 7: Migrate tools from Homebrew to mise


- [x] 7.1 Audit the Brewfile; for each entry, determine if mise can manage it (check `mise registry`)
- [x] 7.2 Migrate clear-win tools to mise: `ripgrep`, `zoxide`, `openjdk@21`, `maven`; remove from Brewfile
- [ ] 7.2a Deferred: investigate migrating `colima`, `docker`, `cookiecutter`, `postgresql@14` — leave in Brewfile until each has a verified mise path
- [x] 7.3 Investigate why mise shims don't take precedence over Homebrew for `rg`, `java`, `mvn` — fix PATH/shim ordering so mise wins (was a session issue; resolves correctly in fresh zsh)
- [x] 7.4 Audit global npm packages currently installed under asdf's Node (`npm list -g --depth=0`); reinstall any missing ones under mise's Node; document them
- [x] 7.5 Remove `asdf` from Brewfile; confirm mise fully replaces it for all currently asdf-managed tools (`gh`, `fzf`, `jq`, `terraform` resolve via mise; `gcloud` not installed; `bat` not installed)
- [x] 7.6 **Demo**:
  1. Run `mise ls` — confirm all migrated tools are present and active
  2. Run `which rg && which gh && which fzf && which jq` — confirm they resolve via mise, not asdf/brew
  3. Run `git open` — confirm it works
  4. Run `brew bundle check` — confirm Brewfile is consistent with installed state

---

## Stage 8: CI & secret scanning


- [x] 8.1 Write `.github/workflows/ci.yml` — matrix: `macos-latest` + `ubuntu-latest`; applies dotfiles with `is_ci_workflow = true`; runs `test-shell.sh`; startup benchmark on macOS
- [x] 8.2 Expand `test-shell.sh` to test deployed files, aliases, functions, env vars, PATH; make it `mise run test`; drop shellcheck (limited value for personal dotfiles)
- [x] 8.3 Add startup benchmark to CI: `hyperfine --warmup 3 --runs 10 'zsh -i -c exit'` (macOS only)
- [x] 8.4 Add `.gitleaks.toml` with allowlists for `op://` refs, UUIDs, Brewfile hashes
- [x] 8.5 **Demo**:
  1. Run `gh run view --repo lqueryvg/dotfiles-new --log $(gh run list --repo lqueryvg/dotfiles-new -L 1 --json databaseId -q '.[0].databaseId')` — confirm both platforms passed
  2. Run `mise run test` locally — confirm all 29 checks pass

---

## Stage 9: Password manager integration


- [x] 9.1 Write `home/dot_config/dotfile_source/third-party/bitwarden.sh` — `bw-load` (adds `~/.ssh/lqueryvg-github` to ssh-agent, skips if already loaded) and `bw-setup` (one-time interactive unlock + key fetch from Bitwarden Secure Note, writes key to disk); `bitwarden` managed via mise
- [x] 9.2 Write `home/dot_config/dotfile_source/third-party/onepassword.sh` — `op-load` function: checks `$OP_SESSION_LOADED` (skip if set), fetches tokens via `op read op://Employee/<token>/credential`, exports as env vars, sets `OP_SESSION_LOADED=1` only if all tokens loaded
- [x] 9.3 Populate the fixed token list in `op-load` — `GITHUB_PACKAGES_TOKEN`, `JIRA_API_TOKEN`, `CONFLUENCE_API_TOKEN` stored in 1Password Employee vault
- [x] 9.3a Migrate secrets from `~/dotfiles/private.d/bpp.sh` into 1Password; replaced `bpp.sh` with a comment pointing to `op-load`
- [x] 9.4 **Demo**: `bw-load` adds key to agent (skips if already loaded); `bw-setup` skips if key on disk; `op-load` exports tokens silently, skips on second call, retries if any token failed

---

## Stage 10: mise tool installation

- [ ] 10.1 Write `home/.chezmoiscripts/run_onchange_15-mise-install.sh.tmpl` — runs `mise install` when `.tool-versions` changes; hash comment on `.tool-versions`; skipped in CI (`{{ if not .is_ci_workflow }}`); gated on mise being available
- [ ] 10.2 **Demo**: run `mise run demo` — confirm test user has mise tools installed (`which rg`, `which gh`, `which fzf` resolve via mise shims after bootstrap)

---

## Stage 11: README

- [ ] 11.1 Finish `README.md` (skeleton written in Stage 9) — verify and expand:
  - **Quick start**: single bootstrap command + post-bootstrap manual steps (bw-setup, op-load)
  - **Philosophy**: mise first, Homebrew as last resort; what goes where and why
  - **Runbook**: adopt a dotfile, add a bin script, add a shell tool to `dotfile_source/`
- [ ] 11.2 **Demo**: read through the README as a new user; confirm quick start command is correct and runbook steps work

---

## Stage 12: Migration cutover


> ⚠️ **HIGH RISK STAGE** — 12.2 removes dual-sourcing (shell breaks if anything wasn't migrated); 12.4 deletes `~/dotfiles` (irreversible locally — GitHub is the backup). Do not proceed unless CI is green and the test-user demo passes.

- [ ] 12.1 Verify `~/dotfiles/home_links` is empty (all entries migrated or intentionally dropped)
- [ ] 12.2 Remove dual-sourcing loop from `home/dot_zshrc.tmpl` (delete the `~/dotfiles/my_zshrc.sh` source block)
- [ ] 12.3 `chezmoi apply` — confirm shell still works with only new `dotfile_source/`
- [ ] 12.4 Archive `~/dotfiles` repo: rename to `dotfiles-legacy` on GitHub; remove `~/dotfiles` from local machine
- [ ] 12.5 Rename `dotfiles-new` to `dotfiles` on GitHub; update chezmoi bootstrap command everywhere it's documented
- [ ] 12.6 Run `mise run test-user-create` — full bootstrap from scratch with final repo name; verify end-to-end
- [ ] 12.7 **Demo**: fresh test user runs `curl -fsLS get.chezmoi.io | sh -s -- init --apply github.com/lqueryvg/dotfiles`; gets a fully working shell; all tools present; git identity correct; tear down test user; commit final state

---

## Stage 13: Claude Code settings

- [ ] 13.1 Identify Claude config files to manage: `~/.claude/settings.json`, `~/.claude/CLAUDE.md`, `~/.claude/commands/`
- [ ] 13.2 Add to `home/private_dot_config/private_claude/` — use `private_` prefix (mode 0700); exclude `settings.local.json` (machine-specific permissions, never committed)
- [ ] 13.3 `mise run adopt` the Claude config files
- [ ] 13.4 **Demo**: apply on test user; confirm `~/.claude/settings.json` and `~/.claude/CLAUDE.md` exist with correct content

---

## Stage 14: macOS settings & app configs (near future)


- [ ] 14.1 Write `install/macos-defaults.sh` — `defaults write` commands for system preferences (dock, keyboard, trackpad, UI); structured by domain with comments
- [ ] 14.2 Add `home/.chezmoiscripts/run_onchange_50-macos.sh.tmpl` — wraps `install/macos-defaults.sh`; hash comment triggers re-run when the script changes; macOS only
- [ ] 14.3 Export iTerm2 profile to JSON; add to `home/Library/Application Support/iTerm2/DynamicProfiles/`; add `run_once_` script to set iTerm2 custom folder preference
- [ ] 14.4 Add Firefox to Brewfile (cask); write `run_once_` script to configure default profile
- [ ] 14.5 **Demo**: on test user, run bootstrap; confirm macOS preferences applied (`defaults read` key assertions); iTerm2 profile present; Firefox installed
