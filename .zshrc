#echo .zshrc start

source ~/dotfiles/my_functions.sh

source_if_exists "${HOME}/.my_profile.sh"

source /Users/jbu46/mygit/zsh-git-prompt/zshrc.sh
#PROMPT='%B%m%~%b$(git_super_status) %# '
#PROMPT='%~%b$(git_super_status)$ '
PROMPT='$(basename $(pwd))$(git_super_status)/ '

#function powerline_precmd() {
#    PS1="$(~/mygit/powerline-shell/powerline-shell.py \
#      --mode flat                                     \
#      --cwd-only                                      \
#      --shell zsh $? 2> /dev/null                     \
#    )"
#}
#
#function install_powerline_precmd() {
#  for s in "${precmd_functions[@]}"; do
#    if [ "$s" = "powerline_precmd" ]; then
#      return
#    fi
#  done
#  precmd_functions+=(powerline_precmd)
#}
#
#if [ "$TERM" != "linux" ]; then
#    install_powerline_precmd
#fi

# use vi for history & command editing
source_if_exists ~/.my_aliases

export SHELL=zsh
HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000
setopt share_history
setopt inc_append_history
bindkey -v
zstyle :compinstall filename '/Users/jbu46/.zshrc'
autoload -Uz compinit
compinit
