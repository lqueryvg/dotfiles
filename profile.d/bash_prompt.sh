
if [[ $SHELL_IS_BASH == true && $SHELL_IS_INTERACTIVE == true ]]
then
  :
else
  return
fi

powerline=~/mygit/powerline-shell/powerline-shell.py
if [[ -f ~/.liquidprompt ]]
then
  [[ $- = *i* ]] && source ~/.liquidprompt
elif [[ -x $powerline ]]
then
  function _update_ps1() {
    PS1="$($powerline         \
            --cwd-max-depth 2 \
            --mode compatible \
            $? 2> /dev/null)"
            #--mode flat \
  }

  if [ "$TERM" != "linux" ]; then
    PROMPT_COMMAND="_update_ps1; $PROMPT_COMMAND"
  fi
else
  PS1=$(whoami)"$ "
fi

