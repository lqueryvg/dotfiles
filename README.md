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

- `~/.zshrc` (for interactive `zsh` shells)
  - `~/.my_zshrc`
    - `~/dotfiles/my_functions.sh`
    - `~/.my_profile.sh`
      - `~/dotfiles/public.d/*.sh`
      - `~/dotfiles/private.d/*.sh` 
          - in `.gitignore`, put private or machine specific startup here)

- `~/.bash_profile` (for interactive login `bash` shells, i.e. every window)
  - `~/dotfiles/my_functions.sh`
  - `exec_if_exists $HOME/homebrew/bin/zsh`
  - `source_if_exists $HOME/.bashrc`

- `~/.bashrc` (for interactive non-login `bash` shells)
  - `~/dotfiles/my_functions.sh`
  - `~/.my_profile.sh`

