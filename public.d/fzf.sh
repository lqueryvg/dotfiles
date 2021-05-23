is_zsh || return
is_interactive || return

base_fzf_command="fd . --ignore-file ~/dotfiles/fzf/ignore_dirs.txt"
# files
export FZF_CTRL_T_COMMAND="$base_fzf_command -t f"

# directories
export FZF_ALT_C_COMMAND="$base_fzf_command -t d"

_fzf_compgen_path() {
  eval command $base_fzf_command -t f $1
}

_fzf_compgen_dir() {
  eval command $base_fzf_command -t d $1
}

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

bindkey '^g' fzf-cd-widget
bindkey '^f' fzf-file-widget
