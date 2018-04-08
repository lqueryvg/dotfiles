[[ $functions_already_sourced == 1 ]] && {
  #echo my_functions.sh already done
  return
}
echo my_functions.sh

#echo my_functions.sh start
functions_already_sourced=1

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
      echo source $f
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

append_path_if_exists() {
  for d in $@
  do
    echo "d=$d"
    if [[ -d "$d" ]] ; then
      PATH="${PATH}:$d"
      export PATH
    fi
  done
}

prepend_path_if_exists() {
  for d in $*
  do
    if [[ -d "$d" ]] ; then
      PATH="$d:${PATH}"
      export PATH
    fi
  done
}

# set window title
title() {
  echo -ne "\033]0;"$1"\007"
}

venv() {
  source_first_if_exists \
    venv/bin/activate    \
    ~/projects/azure/dist/venv/bin/activate
}

#echo my_functions.sh end

