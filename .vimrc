"---------------------------------------------------------
" Source modules if vundle present
set nocompatible          " be iMproved (required)
if filereadable(expand('~/.vim/bundle/vundle/autoload/vundle.vim'))
    source ~/.vim/startup/modules.vim
endif

"---------------------------------------------------------

" My preferences
"syntax on
set t_Co=256              " enable 256-color mode.
syntax enable             " enable syntax highlights (prev. syntax on).
color skittles_dark
"set laststatus=2         " last window always has a statusline
"filetype plugin indent on " activates indenting for files
"colorscheme desert        " set colorscheme
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
"set colorcolumn=80          " highlight column 80 to watch out for long lines
set cursorline              " highlight column 80 to watch out for long lines
set keywordprg=:help        " K calls :help on word under cursor
set wildmenu
" Start scrolling three lines before the horizontal window border
set scrolloff=3
"set textwidth=0

"---------------------------------------------------------
" window split chars and status line
" hopefully we'll be able to distinguish the active window
set fillchars+=stl:=,stlnc:_
set fillchars+=vert:\|
set statusline=
set statusline+=%f        " filename as type or relative to current dir
set statusline+=\         " space
set statusline+=%=        " go over to the right
set statusline+=\         " space
set statusline+=%l,%c     " line, column
set statusline+=\         " space
set statusline+=%p%%      " percentage thru file
set statusline+=\         " space
set statusline+=b%n       " buffer num "bn"
set statusline+=%M        " modified ",+" or ",-"
set statusline+=%R        " readonly ",RO"
set statusline+=\         " space
set laststatus=2          " show my statusline even if only 1 window
"---------------------------------------------------------

" make 81st column stand out (from Damien Conway)
highlight ColorColumn ctermbg=cyan ctermfg=black
call matchadd('ColorColumn', '\%81v', 100)

" status line

" Make cursorline only visible in active windows
augroup CursorLine
    au!
    au VimEnter * setlocal cursorline
    au WinEnter * setlocal cursorline
    au BufWinEnter * setlocal cursorline
    au WinLeave * setlocal nocursorline
augroup END

" Automatic loading of .vimrc
autocmd! BufWritePost .vimrc source %

"-------------------------------------------------------
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

" indent visual block without losing selection
vnoremap < <gv
vnoremap > >gv

map <C-Down> <C-w>j
map <C-Up> <C-w>k
map <C-Left> <C-w>h
map <C-Right> <C-w>l

"-----------------------------------------------------
" Leader mappings
" Rebind <Leader> key
"let mapleader = "\\"

" Cycle tabs
map <Leader>h <esc>:tabprevious<CR>
map <Leader>l <esc>:tabnext<CR>

" sort
vnoremap <Leader>s :sort<CR>
