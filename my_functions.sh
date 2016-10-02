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
  [[ -x $1 ]] && exec $*
}

source_if_exists() {
  for f in $*
  do
    [[ -f $f ]] && source $f
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
