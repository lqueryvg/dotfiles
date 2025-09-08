# dotfiles

```
cd ~
git clone https://github.com/lqueryvg/dotfiles.git
cd dotfiles
./install
git clone https://github.com/gmarik/Vundle.vim.git ~/.vim/bundle/Vundle.vim
vim
:PluginInstall
mkdir ~/.vimtmp
```

## Order of execution

### zsh

#### interactive shells

- `~/.zshrc`
  - `~/dotfiles/my_zshrc.sh`
    - `~/dotfiles/my_functions.sh`
    - `~/.my_profile.sh`
      - `~/dotfiles/public.d/*.sh`
      - `~/dotfiles/private.d/*.sh`

### bash

#### interactive shells

- `~/.bash_profile`
  - `~/dotfiles/my_functions.sh`
  - `exec_if_exists $HOME/homebrew/bin/zsh`
  - `source_if_exists $HOME/.bashrc`

#### non-interactive shells

- `~/.bashrc`
  - `~/dotfiles/my_functions.sh`
  - `~/.my_profile.sh`
    - `~/dotfiles/public.d/*.sh`
    - `~/dotfiles/private.d/*.sh`
