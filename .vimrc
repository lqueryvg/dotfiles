"---------------------------------------------------------
set nocompatible          " be iMproved (required)

let g:jellybeans_background_color_256 = "black"
" fixed font looks awful in italics, so turn it off for jellybeans
let g:jellybeans_overrides = {
\ 'Comment': { 'attr': ''},
\ 'StatusLine': { 'attr': ''},
\ 'StatusLineNC': { 'attr': ''},
\ 'Folded': { 'attr': ''},
\ 'TabLine': { '256ctermfg': 'Grey', '256ctermbg': 'Black', 'attr': ''},
\ 'TabLineSel': { '256ctermbg': 'White', 'attr': ''},
\}

" Source modules if vundle present
if filereadable(expand('~/.vim/bundle/Vundle.vim/autoload/vundle.vim'))
    source ~/.vim/startup/modules.vim
endif

"---------------------------------------------------------
" Colors

set t_Co=256              " enable 256-color mode.
syntax enable             " enable syntax highlights (prev. syntax on).
"color skittles_dark
"set laststatus=2         " last window always has a statusline
"filetype plugin indent on " activates indenting for files
"colorscheme desert        " set colorscheme

colorscheme jellybeans

" make 81st column stand out (from Damien Conway)
if (exists("*matchadd"))
    highlight ColorColumn ctermbg=cyan ctermfg=black
    call matchadd('ColorColumn', '\%81v', 100)
endif

"---------------------------------------------------------
" Misc
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
set keywordprg=:help        " K calls :help on word under cursor
set wildmenu                " tab show menu on command line
set scrolloff=3             " scroll to keep 3 lines above or below cursor
set hidden             " can now switch buffers without being forced to save
if (has('mouse'))
    set mouse=nvch              " mouse works in all modes except insert
endif
"set textwidth=0

"---------------------------------------------------------
" GUI options
if has("gui_running")
    set guioptions+=a       " autoselect to system clipboard *
    set guioptions-=T       " remove toolbar
    set guioptions-=r       " remove R scrollbar
    set guioptions-=L       " remove L scrollbar
    set guifont=fixed:h9:cANSI
endif

"---------------------------------------------------------
set formatoptions=
silent! set formatoptions+=j   " sensibly remove comment chars on joining lines
set formatoptions+=q   " allow gq to format comments
set formatoptions+=l   " long lines not broken in insert mode
set formatoptions+=n   " recognise numbered lists when formatting
                       "   needs autoindent set, and uses formatlistpat
set formatoptions+=o   " add comment leader with o or O
set formatoptions+=r   " add comment leader on <Enter> in insert mode

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

" status line

" commenting out cursorline because I can't see yellow Notes or 'TODO's
"set cursorline
" Make cursorline only visible in active windows
"augroup CursorLine
"    au!
"    au VimEnter * setlocal cursorline
"    au WinEnter * setlocal cursorline
"    au BufWinEnter * setlocal cursorline
"    au WinLeave * setlocal nocursorline
"augroup END

" Auto load .vimrc if it changes
autocmd! BufWritePost .vimrc source %

"-------------------------------------------------------
" Key maps
" DO NOT put comments ON END of map lines

" Map accidents to something sensible
command! Q q
command! -bang Q q<bang>

" Open a new tab
command! TT tabnew

" disable Q and gQ (which puts you in fancy ex mode)
" can still access it through q:
nnoremap Q <Nop>
nnoremap gQ <Nop>

" disable K which trys to man the word under cursor
"nnoremap K <Nop>

" move between windows with Ctrl then movement key
noremap <c-h> <c-w>h
noremap <c-j> <c-w>j
noremap <c-k> <c-w>k
noremap <c-l> <c-w>l
" Annoying messages until I get the new mapping
noremap <c-w>h <esc>:echoerr '>>>>>> use ^h to move left split <<<<<<<<<<'<CR>
noremap <c-w>j <esc>:echoerr '>>>>>> use ^j to move right split <<<<<<<<<<'<CR>
noremap <c-w>k <esc>:echoerr '>>>>>> use ^k to move up split <<<<<<<<<<'<CR>
noremap <c-w>l <esc>:echoerr '>>>>>> use ^l to move down split <<<<<<<<<<'<CR>

" indent visual block without losing selection
vnoremap < <gv
vnoremap > >gv

"-----------------------------------------------------
" Leader mappings
" Rebind <Leader> key
"let mapleader = "\\"

" Cycle tabs
map <Leader>h <esc>:tabprevious<CR>
map <Leader>l <esc>:tabnext<CR>

" Annoying messages until I get the new mapping
noremap gT <esc>:echoerr '>>>>>>>> use \h to move to left tab  <<<<<<<<<<'<CR>
noremap gt <esc>:echoerr '>>>>>>>> use \l to move to right tab <<<<<<<<<<'<CR>

" sort
vnoremap <Leader>s :sort<CR>
