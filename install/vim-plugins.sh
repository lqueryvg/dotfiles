#!/usr/bin/env bash
set -euo pipefail

VUNDLE_DIR="${HOME}/.vim/bundle/Vundle.vim"

if [[ -d "${VUNDLE_DIR}" ]]; then
  echo "Vundle already installed, skipping clone"
else
  echo "Installing Vundle..."
  git clone https://github.com/VundleVim/Vundle.vim.git "${VUNDLE_DIR}"
fi

echo "Installing vim plugins..."
vim +PluginInstall +qall
echo "Done"
