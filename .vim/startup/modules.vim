
"modules
filetype off            " required!
set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

" let vundle manage vundle
Bundle 'gmarik/vundle'
Bundle 'scrooloose/nerdtree'
Bundle 'vim-scripts/mru.vim'
Bundle 'vim-scripts/jshint.vim'
"Bundle 'altercation/vim-colors-solarized'
Bundle 'pangloss/vim-javascript'

" fuzzy search filenames
let g:ctrlp_extensions = [ 'tag', 'buffertag', 'quickfix', 'dir',
  \ 'rtscript', 'undo', 'line', 'changes', 'mixed', 'bookmarkdir' ]
Bundle 'kien/ctrlp.vim'

" */# Search forwards/back for text under vis selection
Bundle 'nelstrom/vim-visual-star-search'

" Syntax highlight for md files
Bundle 'gabrielelana/vim-markdown'

filetype plugin indent on " required!


"======================================================================
" Module config

let g:ctrlp_show_hidden = 1     " include dot files and dot dirs
let g:ctrlp_working_path_mode = 0   " don't start in current dir

let g:loaded_youcompleteme = 1      " source code completion
let NERDTreeShowBookmarks=1
