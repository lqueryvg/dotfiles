```
cd ~
git clone https://github.com/lqueryvg/dotfiles.git
cd dotfiles
./install
git clone https://github.com/gmarik/Vundle.vim.git ~/.vim/bundle/Vundle.vim
vim
:PluginInstall
```

# Order of execution
- ~/.zshrc
  - ~/.my_zshrc
    - ~/dotfiles/my_functions.sh
    - ~/my_profile.sh
      - ~/my_aliases.sh
      - ~/local_profile.sh

