# common to bash and zsh

echo .my_profile.sh start

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
      # This is a script
      ;;
esac

prepend_path_if_exists            \
  ${HOME}/bin                     \
  ${HOME}/dotfiles/bin

#source_if_exists ${HOME}/.local_profile

for file in ~/dotfiles/profile.d/*.sh \
            ~/dotfiles/local.d/*.sh
do
  echo -n ${file##*/}" "    # basename
  source $file
done

echo .my_profile end
