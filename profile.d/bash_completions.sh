[[ $SHELL_IS_BASH != "true" ]] && return
[[ $SHELL_IS_INTERACTIVE != "true" ]] && return

source_if_exists                    \
  /etc/.bash_completion             \
  /etc/profile.d/bash_completion.sh \
  ~/.bash_completion

d=~/homebrew/etc/bash_completion.d
[[ -d $d ]] && {
    for file in $d/*
    do
      . $file
    done
}

bcdir=~/dotfiles/bash_completion.d
[[ -d $bcdir ]] && for file in $bcdir/*
do
    source $file
done

