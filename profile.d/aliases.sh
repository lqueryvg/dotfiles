# for bash and zsh...

# only run these when interactive
[[ $SHELL_IS_INTERACTIVE == true ]] || return

# Interactive operation...
alias rm='rm -i'
alias cp='cp -i'
alias mv='mv -i'

# Default to human readable figures
alias df='df -h'
alias du='du -h'

# alias less='less -r'              # raw control characters
alias whence='type -a'              # like where
alias grep='grep --color'           # show matches in colour
#alias cgrep='egrep --color=always'  # color even to pipe
alias egrep='egrep --color=auto'    # show matches in colour
alias fgrep='fgrep --color=auto'    # show matches in colour
alias ls='ls -hF --color=always'    # classify files in colour
[[ $(uname) == Darwin ]] && alias ls='ls -hF -G'
alias less='less -R'                # ls pipe less is in colour
alias pgrep='pgrep -a'
alias mvi=~/dotfiles/bin/mvim.sh
alias mvim=~/dotfiles/bin/mvim.sh
alias r='sudo su -'
alias rif='rifle'
alias vm='virt-manager'

#vim="nvim"
vim="vim"
if hash vimx 2>/dev/null
then
  vim=vimx
fi
alias vim='$vim'
alias view='$vim -R'
alias vlcdot='nohup vlc . 2>&1 > /dev/null &'

alias more='less'
alias ap="ansible-playbook"
alias vs="vagrant ssh"
#alias ae=". /data/software/ansible/hacking/env-setup; cd ~/ansible"
alias ae=". /data/software/ansible/hacking/env-setup"
alias atm="/data/software/ansible/hacking/test-module"
alias rr=rifle
alias ic=i2cssh
alias h=history
alias help='pushd ~/technotes; vim *.md; popd'
#alias vim=callvim
#alias v=callvim
alias vi=vim
alias i2cssh='RUBYOPT="-W0" i2cssh'
alias k=kubectl
alias pu=pushd
alias po=popd
alias tn='cd ~/technotes'
#alias venv="source venv/bin/activate"


# local stuff
