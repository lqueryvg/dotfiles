[[ $functions_already_sourced == 1 ]] && {
  #echo my_functions.sh already done
  return
}

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

append_path_if_exists() {
  for d in $*
  do
    if [[ -d $d ]] ; then
      PATH="${PATH}:$d"
      export PATH
    fi
  done
}

prepend_path_if_exists() {
  for d in $*
  do
    if [[ -d $d ]] ; then
      PATH="$d:${PATH}"
      export PATH
    fi
  done
}

#echo my_functions.sh end
