# Only run if this is zsh
[[ $SHELL_IS_ZSH == "true" ]] || return

# Only run if interactive shell
[[ $SHELL_IS_INTERACTIVE == true ]] || return

# turn off bracketed paste mode
# so that I can immediately execute commands that I paste
unset zle_bracketed_paste
export EDITOR=vim
