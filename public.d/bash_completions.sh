is_bash || return
is_interactive || return

source_if_exists                    \
  /etc/.bash_completion             \
  /etc/public.d/bash_completion.sh \
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

