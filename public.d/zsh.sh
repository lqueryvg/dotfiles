is_zsh || return
is_interactive || return

# turn off bracketed paste mode
# so that I can immediately execute commands that I paste
unset zle_bracketed_paste
export EDITOR=vim

# change directory without cd
setopt auto_cd

# Basic auto/tab complete:
autoload -U compinit
zstyle ':completion:*' menu select
zmodload zsh/complist
compinit
_comp_options+=(globdots)

# Use vim keys in tab complete menu:
bindkey -M menuselect 'h' vi-backward-char
bindkey -M menuselect 'k' vi-up-line-or-history
bindkey -M menuselect 'l' vi-forward-char
bindkey -M menuselect 'j' vi-down-line-or-history

# zsh-autosuggestions.zsh
source_if_exists ${HOME}/git/zsh-autosuggestions/zsh-autosuggestions.zsh

# command line syntax highlighting
zinit load zsh-users/zsh-syntax-highlighting

# powerlevel10k prompt
zinit ice depth=1; zinit light romkatv/powerlevel10k
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
