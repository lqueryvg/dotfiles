# Philosophy: Homebrew is a last resort — only for tools with no viable mise path.
# Tools currently managed by asdf (gh, fzf, jq, terraform, bat, gcloud) are NOT
# listed here; they will move to mise when asdf is retired.

tap "ankitpokhrel/jira-cli"
tap "isindir/git-get"

# --- Version managers ---
# TODO: remove once fully migrated to mise
brew "asdf"

# --- Core utilities ---
brew "coreutils"        # GNU file, shell, and text utilities (gdate, greadlink, etc.)
brew "ripgrep"          # Fast grep replacement
brew "tree"             # Directory tree display
brew "zoxide"           # Smarter cd
brew "gnupg"            # GPG

# --- Containers ---
brew "colima"           # Container runtime for macOS
brew "docker"           # Docker CLI
brew "docker-buildx"    # Extended build capabilities
brew "docker-credential-helper"  # Keychain credential storage for Docker

# --- Data / PDF ---
brew "poppler"          # PDF rendering (pdftotext etc.)
brew "postgresql@14"    # PostgreSQL (local dev)

# --- Java ---
brew "openjdk@21", link: true
brew "maven"

# --- Project tooling ---
brew "cookiecutter"     # Project scaffolding from templates
brew "jira-cli"         # Jira CLI

# --- Casks ---
cask "1password-cli"    # op CLI for secret access
cask "claude-code"      # Claude Code CLI
cask "finicky"          # Browser router
cask "isindir/git-get/git-get"  # Clone multiple repos via Gitfile

