# common to bash and zsh

# echo .my_profile.sh start

case $- in
  *i*)
      # This shell is interactive
      # editor to use when pressing 'v' in command line edit
      export VISUAL=vim
      #source_if_exists  ~/.my_aliases
      title $(uname -n)
      export SHELL_IS_INTERACTIVE=true
      ;;
  *) 
      # This is a non-interactive script
      ;;
esac

prepend_path_if_exists            \
  ${HOME}/bin                     \
  ${HOME}/dotfiles/bin

#source_if_exists ${HOME}/.local_profile

source_files() {
  echo "$(blue Source:) $1/*.sh"
  for file in $1/*.sh
  do
    echo -n $(lilac "${file##*/} ")    # basename
    source $file
  done
  #echo
}

source_files ~/dotfiles/public.d
source_files ~/dotfiles/private.d

echo "$(blue "Path additions:") $PATH_ADDITIONS"
unset PATH_ADDITIONS

#echo .my_profile end
