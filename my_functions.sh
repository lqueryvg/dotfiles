[[ $functions_already_sourced == 1 ]] && {
  #echo my_functions.sh already done
  return
}

echo my_functions.sh start

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

command_exists() {
  command -v $1 > /dev/null 2>&1
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
      echo source $(basename $f)
      . $f
    fi
  done
}

source_first_if_exists() {
  for f in $*
  do
    if [[ -f $f ]]
    then
      echo source $f
      . $f
      return
    fi
  done
}

append_path() {
  echo "PATH+ '$1'"
  PATH="${PATH}:$1"
  export PATH
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
    $d/profile.d/$1 \
    $d/profile.d/$1.sh \
    $d/local.d/$1 \
    $d/local.d/$1.sh
}

#echo my_functions.sh end

