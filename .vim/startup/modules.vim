
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
Bundle 'kien/ctrlp.vim'
"let g:ctrlp_extensions = [ 'tag', 'buffertag', 'quickfix', 'dir',
"  \ 'rtscript', 'undo', 'line', 'changes', 'mixed', 'bookmarkdir' ]
" The Silver Searcher
if executable('ag')
  " Use ag over grep
  set grepprg=ag\ --nogroup\ --nocolor

  " Use ag in CtrlP for listing files. Lightning fast and respects .gitignore
  let g:ctrlp_user_command = 'ag %s -l --nocolor --ignore="*.jpg"'
  let g:ctrlp_user_command += ' --ignore="*.zip" -g ""'

  " ag is fast enough that CtrlP doesn't need to cache
  "let g:ctrlp_use_caching = 0
endif
let g:ctrlp_show_hidden = 1
let g:ctrlp_working_path_mode = 0
set wildignore+=*.jpg

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
