_base_fzf_command="fd . --ignore-file ${HOME}/.config/fzf/ignore_dirs.txt"
export FZF_CTRL_T_COMMAND="${_base_fzf_command} -t f"
export FZF_ALT_C_COMMAND="${_base_fzf_command} -t d"

_fzf_compgen_path() { eval command ${_base_fzf_command} -t f "$1" }
_fzf_compgen_dir()  { eval command ${_base_fzf_command} -t d "$1" }

[[ -f ~/.fzf.zsh ]] && source ~/.fzf.zsh

(( ${+widgets[fzf-cd-widget]} )) && bindkey '^g' fzf-cd-widget
(( ${+widgets[fzf-file-widget]} )) && bindkey '^f' fzf-file-widget
