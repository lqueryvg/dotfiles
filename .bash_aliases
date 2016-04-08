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
alias cgrep='egrep --color=always'  # color even to pipe
alias egrep='egrep --color=auto'    # show matches in colour
alias fgrep='fgrep --color=auto'    # show matches in colour
alias ls='ls -hF --color=always'    # classify files in colour
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
alias vi='$vim'
alias view='$vim -R'
alias vlcdot='nohup vlc . 2>&1 > /dev/null &'

alias more='less'
alias ap="ansible-playbook"
alias vs="vagrant ssh"
alias ae=". /data/software/ansible/hacking/env-setup; cd ~/ansible"
alias atm="/data/software/ansible/hacking/test-module"
alias rr=rifle
