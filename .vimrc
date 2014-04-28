"=========================================================
"modules
set nocompatible          " be iMproved (required)
filetype off            " required!
set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

" let vundle manage vundle
Bundle 'gmarik/vundle'
Bundle 'scrooloose/nerdtree'
Bundle 'vim-scripts/mru.vim'
Bundle 'vim-scripts/jshint.vim'
Bundle 'altercation/vim-colors-solarized'
Bundle 'pangloss/vim-javascript'

" fuzzy search filenames
Bundle 'kien/ctrlp.vim'

" */# Search forwards/back for text under vis selection
Bundle 'nelstrom/vim-visual-star-search'

" Syntax highlight for md files
Bundle 'gabrielelana/vim-markdown'

filetype plugin indent on " required!

let g:ctrlp_extensions = [ 'tag', 'buffertag', 'quickfix', 'dir',
  \ 'rtscript', 'undo', 'line', 'changes', 'mixed', 'bookmarkdir' ]

let g:ctrlp_show_hidden = 1     " include dot files and dot dirs
let g:ctrlp_working_path_mode = 0   " don't start in current dir

let g:loaded_youcompleteme = 1      " source code completion
let NERDTreeShowBookmarks=1
"=========================================================

" My preferences
set t_Co=256              " enable 256-color mode.
syntax enable             " enable syntax highlights (prev. syntax on).
"set laststatus=2         " last window always has a statusline
"filetype plugin indent on " activates indenting for files
colorscheme desert        " set colorscheme
set hlsearch              " highlight searched phrases.
set incsearch             " highlight as you type your search.
set ignorecase            " Make searches case-insensitive.
set ruler                 " Always show info along bottom.
set autoindent            " auto-indent
set tabstop=4             " tab spacing
set shiftwidth=4          " indent/outdent by this many columns
set softtabstop=4         " unify?
set expandtab             " use spaces instead of tabs
set shiftround            " always indent/outdent to the nearest tabstop
set smarttab              " use tabs at the start of a line, spaces elsewhere
set backspace=indent,start  " BS over autoindents and start of insert
set mouse=nvch              " mouse works in all modes except insert
set colorcolumn=80          " highlight column 80 to watch out for long lines
set cursorline              " highlight column 80 to watch out for long lines
set keywordprg=:help        " K calls :help on word under cursor
"set textwidth=0


"execute pathogen#infect()

syntax on
filetype plugin indent on

color skittles_dark
set wildmenu

" Automatic loading of .vimrc
autocmd! BufWritePost .vimrc source %

" Key maps
" DO NOT put comments ON END of map lines

" Map accidents to something sensible
command! Q q
command! -bang Q q<bang>

" Open a new tab
command! TT tabnew

" disable Q and gQ (which puts you in useless ex mode)
nnoremap Q <Nop>
nnoremap gQ <Nop>

" disable K which trys to man the word under cursor
"nnoremap K <Nop>

" move between windows with Ctrl then movement key
map <c-h> <c-w>h
map <c-j> <c-w>j
map <c-k> <c-w>k
map <c-l> <c-w>l

" Rebind <Leader> key
"let mapleader = "\\"

" Cycle tabs

map <Leader>h <esc>:tabprevious<CR>
map <Leader>l <esc>:tabnext<CR>

" sort
vnoremap <Leader>s :sort<CR>

" indent visual block without losing selection
vnoremap < <gv
vnoremap > >gv

map <C-Down> <C-w>j
map <C-Up> <C-w>k
map <C-Left> <C-w>h
map <C-Right> <C-w>l

