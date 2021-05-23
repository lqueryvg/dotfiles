# Keeping my zshrc settings separate from oh-my-zsh

# echo my_zshrc.sh start

source ~/dotfiles/my_functions.sh

# powerline=~/mygit/powerline-shell/powerline-shell.py
# if [[ -f ~/homebrew/share/liquidprompt ]]
# then
#   [[ $- = *i* ]] && source ~/homebrew/share/liquidprompt
# elif [[ -x $powerline ]]
# then
#   function _update_ps1() {
#     PS1="$($powerline         \
#             --cwd-max-depth 2 \
#             --mode compatible \
#             $? 2> /dev/null)"
#             #--mode flat \
#   }

#   if [ "$TERM" != "linux" ]; then
#     PROMPT_COMMAND="_update_ps1; $PROMPT_COMMAND"
#   fi
# else
#   PS1=$(whoami)"$ "
# fi

if [[ -f ~/mygit/zsh-git-prompt/zshrc.sh ]]
then
  source ~/mygit/zsh-git-prompt/zshrc.sh
  PROMPT='$(basename $(pwd))$(git_super_status)/ '
else
  ;
fi

[[ -z $PROMPT ]] && PROMPT='$(whoami)$ '

export SHELL=/bin/zsh
HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000
setopt interactivecomments
setopt inc_append_history
#setopt share_history
bindkey -v
#zstyle :compinstall filename '/Users/jbu46/.zshrc'
#autoload -Uz compinit
#compinit
zstyle ':completion:*' completer _complete
zstyle ':completion:*' matcher-list '' 'm:{[:lower:][:upper:]}={[:upper:][:lower:]}' '+l:|=* r:|=*'
autoload -Uz compinit
compinit


if [[ $(uname) == "Linux" ]]
then
  # make keys behave sensibly
  bindkey "^[OH"  vi-beginning-of-line # Home
  bindkey "^[OF"  vi-end-of-line       # End
  bindkey "^[[3~" delete-char          # Delete
  bindkey "^[[2~" beep                 # Insert (make passive)
fi

alias -g pg=' | grep --color'

# I don't use vi-mode because it messes with my PageUp key.
# But without it, I need to configure 'v' to enter full screen editor
# when editing command line, as follows...
export VISUAL=vim
autoload edit-command-line; zle -N edit-command-line
bindkey -M vicmd v edit-command-line

# use grid selection for completion
zstyle ':completion:*' menu select

source_if_exists "${HOME}/.my_profile.sh"

if [[ $- == *i* ]];then
  echo "$( basename $0 ) loaded"
fi

