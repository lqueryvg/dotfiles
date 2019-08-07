disable_git_hooks() {
  hooks=$(git rev-parse --show-toplevel)/.git/hooks
  if [[ -d $hooks ]]
  then
    mv -f $hooks ${hooks}.disabled
    echo "git hooks disabled"
  else
    echo "git hooks ALREADY disabled"
  fi
}

enable_git_hooks() {
  hooks=$(git rev-parse --show-toplevel)/.git/hooks
  if [[ -d ${hooks} ]]
  then
    echo "git hooks ALREADY enabled"
  else
    if [[ -d ${hooks}.disabled ]]
    then
      mv -f ${hooks}.disabled $hooks
      echo "hooks enabled"
    else
      echo "ERROR: no disabled git hooks"
    fi
  fi
}

alias hd=disable_git_hooks
alias he=enable_git_hooks
