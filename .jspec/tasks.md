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

- [x] 10.1 Write `home/.chezmoiscripts/run_once_00-prerequisites.sh.tmpl` (installs mise via curl if missing) and `run_onchange_15-mise-install.sh.tmpl` (runs `mise install` when `.tool-versions` changes; skipped in CI); `install/brew.sh` updated to skip gracefully if Homebrew prefix not writable; `~/.local/bin` and `~/dotfiles/bin` added to PATH unconditionally
- [x] 10.2 **Demo**: `mise run demo` — test user bootstraps cleanly; all 29 checks pass

---

## Stage 11: README

- [x] 11.1 Finish `README.md` — quick start, post-bootstrap manual steps (bw-setup, op-load), philosophy, runbook (adopt, bin, new tool); runbook kept intentionally lean — grows organically as the solution is used
- [x] 11.2 **Demo**: read through README as a new user; `mise run test` passes

---

## Stage 12: Migration cutover


> ⚠️ **HIGH RISK STAGE** — 12.2 removes dual-sourcing (shell breaks if anything wasn't migrated); 12.4 deletes `~/dotfiles` (irreversible locally — GitHub is the backup). Do not proceed unless CI is green and the test-user demo passes.

**Phase A: Validate on second machine (before touching this machine)**
- [x] 12.1 On second machine: test user bootstrap + `mise run test`; fixed: mise activation order (005-mise.sh), zoxide/fzf guards, Node version (macOS 12 gets Node 22 LTS via template), chezmoi install path forced to `~/.local/bin`, `~/bin` added to PATH
- [x] 12.2 On second machine: full bootstrap on main user; dual-sourcing removed; `~/dotfiles` archived locally; shell clean

**Phase B: Cutover on this machine**
- [x] 12.3 Verified `~/dotfiles/home_links` — Linux/X11/Haskell only, nothing to migrate
- [x] 12.4 Removed dual-sourcing loop from `home/dot_zshrc.tmpl`
- [x] 12.5 `chezmoi apply` — shell works with only new `dotfile_source/`
- [x] 12.6 `~/dotfiles` archived locally; `dotfiles` repo renamed to `dotfiles-legacy` on GitHub
- [x] 12.7 `dotfiles-new` renamed to `dotfiles` on GitHub; README and mise.toml updated
- [x] 12.8 `mise run demo` — full bootstrap with final repo name; all checks pass
- [x] 12.9 **Demo**: complete

---

## Stage 13: Claude Code settings

- [x] 13.1 Identified: `settings.json`, `CLAUDE.md`, `commands/jspec.md`; `settings.local.json` excluded (machine-specific)
- [x] 13.2 Added to `home/private_dot_claude/` (mode 0700); `.chezmoiignore` excludes `settings.local.json`
- [x] 13.3 Adopted via `chezmoi add`
- [x] 13.4 **Demo**: repo moved to `~/dotfiles`; `sourceDir` set in chezmoi config; `~/dotfiles/bin` restored in PATH; Claude Code settings deployed correctly on test user bootstrap

---

## Stage 14: macOS settings & app configs (near future)


- [x] 14.1 Write `install/macos-defaults.sh` — dock (left, auto-hide, size 40, no recents), keyboard (KeyRepeat=2, InitialKeyRepeat=15), Finder (show hidden files, show all extensions), screenshots to ~/Desktop/screenshots/
- [x] 14.2 Add `home/.chezmoiscripts/run_onchange_50-macos.sh.tmpl` — wraps `install/macos-defaults.sh`; hash comment triggers re-run when the script changes; gated on macOS + not CI
- [x] 14.3 Add `ghostty` cask to Brewfile; move Brewfile into chezmoi as `home/Brewfile.tmpl` (deploys to `~/Brewfile`); gate ghostty on `macos_major >= 13`; add `macos_major` to chezmoi data; create `home/dot_config/ghostty/config`
- [ ] 14.4 Add Firefox to Brewfile (cask); write `run_once_` script to configure default profile
- [ ] 14.5 **Demo**: on test user, run bootstrap; confirm macOS preferences applied (`defaults read` key assertions); Ghostty config present at `~/.config/ghostty/config`; Firefox installed
