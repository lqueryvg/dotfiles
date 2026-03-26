# Disable p10k instant prompt (avoids output-ordering complexity)
typeset -g POWERLEVEL9K_INSTANT_PROMPT=off

# Plugin directory for zsh_unplugged
ZPLUGINDIR=${ZPLUGINDIR:-${HOME}/.config/zsh/plugins}

# Clone plugin if missing, add to fpath, then source it
plugin-load() {
  local repo plugdir initfile
  for repo in "$@"; do
    plugdir=$ZPLUGINDIR/${repo:t}
    initfile=$plugdir/${repo:t}.plugin.zsh
    if [[ ! -d $plugdir ]]; then
      echo "Installing zsh plugin: $repo"
      git clone -q --depth 1 --recursive --shallow-submodules \
        https://github.com/$repo $plugdir
    fi
    fpath+=$plugdir
    source $initfile
  done
}

plugin-load \
  zsh-users/zsh-autosuggestions \
  zsh-users/zsh-syntax-highlighting

# Accept autosuggestion with shift+right arrow
bindkey "^[[1;2C" autosuggest-accept

# Powerlevel10k: uses .zsh-theme not .plugin.zsh so loaded separately
_p10k_dir=$ZPLUGINDIR/powerlevel10k
if [[ ! -d $_p10k_dir ]]; then
  echo "Installing zsh plugin: romkatv/powerlevel10k"
  git clone -q --depth 1 https://github.com/romkatv/powerlevel10k $_p10k_dir
fi
source $_p10k_dir/powerlevel10k.zsh-theme
unset _p10k_dir

# Powerlevel10k theme config
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
