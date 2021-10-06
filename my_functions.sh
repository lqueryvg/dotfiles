[[ $functions_already_sourced == 1 ]] && {
  #echo my_functions.sh already done
  return
}

# echo my_functions.sh start

functions_already_sourced=1

if [ -n "$ZSH_VERSION" ]; then
  SHELL_IS_ZSH=true
   # assume Zsh
elif [ -n "$BASH_VERSION" ]; then
  SHELL_IS_BASH=true
else
  # something else
  :
fi

is_bash() {
  [[ $SHELL_IS_BASH == true ]]
}

is_zsh() {
  [[ $SHELL_IS_ZSH == true ]]
}

command_exists() {
  command -v $1 > /dev/null 2>&1
}

is_interactive() {
  [[ $SHELL_IS_INTERACTIVE == true ]]
}

exec_if_exists() {
  if [[ -x $1 ]]
  then
    echo exec $*
    exec $*
  fi
}

source_if_exists() {
  for f in $*
  do
    if [[ -f $f ]]
    then
      echo $(yellow $(basename $f))
      . $f
    fi
  done
}

source_first_if_exists() {
  for f in $*
  do
    if [[ -f $f ]]
    then
      echo Source: $f
      . $f
      return
    fi
  done
}

append_path() {
  PATH="${PATH}:$1"
  PATH_ADDITIONS="${PATH_ADDITIONS}:$1"

  export PATH
  export PATH_ADDITIONS
}

append_path_if_exists() {
  for d in $@
  do
    if [[ -d "$d" ]] ; then
      append_path "$d"
    fi
  done
}

# insert_path() {
#   echo "insert PATH '$1'"
#   PATH="$1:${PATH}"
#   export PATH
# }

prepend_path_if_exists() {
  for d in $*
  do
    if [[ -d "$d" ]] ; then
      PATH="$1:${PATH}"
      export PATH
      # insert_path "$d"
    fi
  done
}

# set window title
title() {
  echo -ne "\033]0;"$1"\007"
}

#venv() {
#  source_first_if_exists \
#    venv/bin/activate    \
#    ~/projects/azure/dist/venv/bin/activate
#}

# "source it"
# e.g. sit kops
# quick way to source a startup file
# can optionally omit the suffix if you happen to know the basename
sit() {
  d=~/dotfiles
  source_first_if_exists \
    $d/public.d/$1 \
    $d/public.d/$1.sh \
    $d/private.d/$1 \
    $d/private.d/$1.sh
}

blue() {
  str="$1"
  echo "\e[0;34m${str}\e[0m"
}

red() {
  str="$1"
  echo "\e[0;31m${str}\e[0m"
}

yellow() {
  str="$1"
  echo "\e[0;33m${str}\e[0m"
}

lilac() {
  str="$1"
  echo "\e[0;36m${str}\e[0m"
}

#echo my_functions.sh end

