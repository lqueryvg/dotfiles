set nocompatible          " get rid of Vi compatibility mode. SET FIRST!
filetype plugin indent on " filetype detection[ON] plugin[ON] indent[ON]
set t_Co=256              " enable 256-color mode.
syntax enable             " enable syntax highlighting (previously syntax on).
colorscheme desert        " set colorscheme
"set laststatus=2         " last window always has a statusline
filetype plugin indent on " activates indenting for files
set hlsearch              " highlight searched phrases.
set incsearch             " highlight as you type your search.
set ignorecase            " Make searches case-insensitive.
set ruler                 " Always show info along bottom.
set autoindent            " auto-indent
set tabstop=2             " tab spacing
set softtabstop=4         " unify
set shiftwidth=2          " indent/outdent by this many columns
set shiftround            " always indent/outdent to the nearest tabstop
set expandtab             " use spaces instead of tabs
set smarttab              " use tabs at the start of a line, spaces elsewhere
set backspace=indent,start  " backspace over autoindents and start of insert
set mouse=nvch            " mouse works in all modes except insert

set rtp+=~/.vim/bundle/vundle/
call vundle#rc()
let g:loaded_youcompleteme = 1 
Bundle 'gmarik/vundle'
let NERDTreeShowBookmarks=1
Bundle 'scrooloose/nerdtree'
Bundle 'vim-scripts/mru.vim'
Bundle 'vim-scripts/jshint.vim'
Bundle 'altercation/vim-colors-solarized'
Bundle 'pangloss/vim-javascript'
Bundle 'kien/ctrlp.vim'

" */# Search forwards/back for text under vis selection
Bundle 'nelstrom/vim-visual-star-search'
execute pathogen#infect()

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

" disable Q and gQ (which puts you in useless ex mode)
nnoremap Q <Nop>
nnoremap gQ <Nop>

" disable K which trys to man the word under cursor
nnoremap K <Nop>

" move between windows with Ctrl then movement key
map <c-h> <c-w>h
map <c-j> <c-w>j
map <c-k> <c-w>k
map <c-l> <c-w>l

" Rebind <Leader> key
let mapleader = ","

" Cycle tabs
map <Leader>n <esc>:tabprevious<CR>
map <Leader>m <esc>:tabnext<CR>

" sort
vnoremap <Leader>s :sort<CR>

" indent visual block without losing selection
vnoremap < <gv
vnoremap > >gv
