"------------------------------------------------------------------------------
"modules
filetype off            " required!
"set rtp+=~/.vim/bundle/vundle/Vundle.vim
set rtp+=~/.vim/bundle//Vundle.vim
call vundle#begin()

" let vundle manage vundle
Plugin 'gmarik/Vundle.vim'
Plugin 'scrooloose/nerdtree'
Plugin 'vim-scripts/mru.vim'
Plugin 'vim-scripts/jshint.vim'
"Bundle 'altercation/vim-colors-solarized'
Plugin 'pangloss/vim-javascript'
Plugin 'nanotech/jellybeans.vim'

" fuzzy search filenames
Plugin 'kien/ctrlp.vim'

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
Plugin 'nelstrom/vim-visual-star-search'

" Syntax highlight for md files
Plugin 'gabrielelana/vim-markdown'

call vundle#end()
filetype plugin indent on " required!


"======================================================================
" Module config

let g:ctrlp_show_hidden = 1     " include dot files and dot dirs
let g:ctrlp_working_path_mode = 0   " don't start in current dir

let g:loaded_youcompleteme = 1      " source code completion
let NERDTreeShowBookmarks=1
