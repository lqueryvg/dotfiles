set nocompatible          " get rid of Vi compatibility mode. SET FIRST!
filetype plugin indent on " filetype detection[ON] plugin[ON] indent[ON]
set t_Co=256              " enable 256-color mode.
syntax enable             " enable syntax highlighting (previously syntax on).
colorscheme desert        " set colorscheme
"set laststatus=2         " last window always has a statusline
filetype plugin indent on " activates indenting for files
set hlsearch              " highlight searched phrases.
set incsearch             " But do highlight as you type your search.
set ignorecase            " Make searches case-insensitive.
set ruler                 " Always show info along bottom.
set autoindent            " auto-indent
set tabstop=2             " tab spacing
set softtabstop=4         " unify
set shiftwidth=2          " indent/outdent by this many columns
set shiftround            " always indent/outdent to the nearest tabstop
set expandtab             " use spaces instead of tabs
set smarttab              " use tabs at the start of a line, spaces elsewhere
set nowrap                " don't wrap text
set backspace=indent,eol,start  " backspace over autoindentations
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

execute pathogen#infect()
syntax on
filetype plugin indent on

color skittles_dark
set wildmenu
