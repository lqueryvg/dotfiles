# dotfiles

```
cd ~
git clone https://github.com/lqueryvg/dotfiles.git
cd dotfiles
./install
git clone https://github.com/gmarik/Vundle.vim.git ~/.vim/bundle/Vundle.vim
vim
:PluginInstall
```

## Order of execution
- ~/.zshrc
  - ~/.my_zshrc
    - ~/dotfiles/my_functions.sh
    - ~/.my_profile.sh
      - ~/dotfiles/profile.d/*.sh
      - ~/dotfiles/local.d/*.sh

- ~/.bashrc
  - ~/dotfiles/my_functions.sh
  - ~/.my_profile.sh
    - SEE ABOVE

- ~/.bash_profile
  - ~/dotfiles/my_functions.sh
  - exec_if_exists $HOME/homebrew/bin/zsh
  - source_if_exists $HOME/.bashrc
