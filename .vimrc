set nocompatible          " be iMproved (required)

" Set a variable to say if we are running in restricted mode (e.g. rvim).
" This will be used later.
silent! call writefile([], '')
" In restricted mode, this fails with E145: Shell commands not allowed in rvim
" In non-restricted mode, this fails with E482: Can't create file <empty>
let g:isRestricted = (v:errmsg =~# '^E145:')

" Modules {{{
"------------------------------------------------------------------------------

" Source modules if vundle present
if filereadable(expand('~/.vim/bundle/Vundle.vim/autoload/vundle.vim'))
    filetype off            " required!
    set rtp+=~/.vim/bundle/Vundle.vim

    call vundle#begin()

    Plugin 'gmarik/Vundle.vim'          " let vundle manage itself

    Plugin 'scrooloose/nerdtree'        " File browser
    let NERDTreeShowBookmarks=1

    Plugin 'vim-scripts/mru.vim'        " Javascript stuff
    Plugin 'nanotech/jellybeans.vim'    " nice colour scheme
    Plugin 'gabrielelana/vim-markdown'  " Syntax highlight for md files
    Plugin 'tommcdo/vim-exchange'       " exchange 2 things, cx{motion}
    Plugin 'hdima/python-syntax'        " python syntax

    " Javascript stuff
    Plugin 'vim-scripts/jshint.vim'
    Plugin 'pangloss/vim-javascript'    

    " */# Search forwards/back for text under vis selection
    Plugin 'nelstrom/vim-visual-star-search'

    Plugin 'kien/ctrlp.vim'             " fuzzy search filenames
    let g:ctrlp_show_hidden = 1     " include dot files and dot dirs
    let g:ctrlp_working_path_mode = 0   " don't start in current dir
    "let g:ctrlp_extensions = [ 'tag', 'buffertag', 'quickfix', 'dir',
    "  \ 'rtscript', 'undo', 'line', 'changes', 'mixed', 'bookmarkdir' ]
    let g:ctrlp_reuse_window = 1        " don't split

    Plugin 'sjl/gundo.vim'                 " visualize undo tree
    Plugin 'rking/ag.vim'                  " Silver Searcher from within vim
    Plugin 'msanders/snipmate.vim'         " snippets
    "Plugin 'klen/python-mode'              " various python tools
    "let g:pymode_python='python3'
    "let g:pymode_lint = 1                  " python pep8 checking
    "let g:pymode_rope = 0                  " rope autocompletion
    
    "Plugin 'davidhalter/jedi-vim'              " code autocompletion

    "Plugin 'scrooloose/syntastic'              " syntax checker
    "let g:syntastic_python_python_exe = 'python3'

    "Plugin 'fholgado/minibufexpl.vim'              " :help MiniBufExpl
    Plugin 'tpope/vim-unimpaired'              " :help unimpaired
    Plugin 'godlygeek/tabular'                  " :help tabular
    Plugin 'rodjek/vim-puppet'                  " :Tabularize /=>
    
    call vundle#end()
    filetype plugin indent on " required!

endif   " modules

"}}}
" Ag - The Silver Searcher {{{
"---------------------------------------------------------
if executable('ag')
    " Use ag over grep
    set grepprg=ag\ --nogroup\ --nocolor

    " Use ag in CtrlP for listing files. Lightning fast and respects .gitignore
    let g:ctrlp_user_command = 'ag %s -l --nocolor --ignore="*.jpg"'
    let g:ctrlp_user_command += ' --ignore="*.zip" -g ""'

    " ag is fast enough that CtrlP doesn't need to cache
    "let g:ctrlp_use_caching = 0
endif
set wildignore+=*.jpg

" }}}
" Colors {{{
"---------------------------------------------------------

set t_Co=256              " enable 256-color mode.
syntax enable             " enable syntax highlights (prev. syntax on).
"color skittles_dark
"set laststatus=2         " last window always has a statusline
"filetype plugin indent on " activates indenting for files
"colorscheme desert        " set colorscheme

let g:jellybeans_background_color_256 = "black"
" fixed font looks awful in italics, so turn it off for jellybeans
let g:jellybeans_overrides = {
    \ 'Comment': { 'attr': ''},
    \ 'StatusLine':   { '256ctermbg': '237', '256ctermfg': 'white', 'attr': ''},
    \ 'StatusLineNC': { '256ctermbg': '234', '256ctermfg': '241',   'attr': ''},
    \ 'WildMenu':     { '256ctermbg': '233', '256ctermfg': '81'},
    \ 'Folded': { '256ctermbg': '0', '256ctermfg': '167', 'attr': ''},
    \ 'TabLine': { '256ctermfg': 'Grey', '256ctermbg': 'Black', 'attr': ''},
    \ 'TabLineSel': { '256ctermbg': 'White', 'attr': ''},
    \}
if (g:isRestricted)
    colorscheme murphy
else
    silent! colorscheme jellybeans
endif

" make 81st column stand out (from Damien Conway)
if (exists("*matchadd"))
    highlight ColorColumn ctermbg=cyan ctermfg=black
    call matchadd('ColorColumn', '\%81v', 100)
endif

"}}}
" Tabs and indents {{{
"---------------------------------------------------------
set textwidth=79
set shiftwidth=4          " indent/outdent by this many columns
set tabstop=4             " tab spacing
set expandtab             " use spaces instead of tabs
set softtabstop=4         " unify?
set shiftround            " always indent/outdent to the nearest tabstop
set autoindent            " auto-indent
"set smarttab              " use tabs at the start of a line, spaces elsewhere

" }}}
" Options {{{
"---------------------------------------------------------
set hlsearch                " highlight searched phrases.
set incsearch               " highlight as you type your search.
set ignorecase              " Make searches case-insensitive.
set ruler                   " Always show info along bottom.
set backspace=indent,start  " BS over autoindents and start of insert
set keywordprg=:help        " K calls :help on word under cursor
set wildmenu                " tab show menu on command line
set scrolloff=3             " scroll to keep 2 lines above or below cursor
set hidden                  " switch buffers without being forced to save
if (has('mouse'))
    set mouse=nvch          " mouse works in all modes except insert
endif
set modelines=1             " comment at end of file gives vim hints
"set foldlevel=99       " no folds closed when buffer opened
autocmd! BufWritePost .vimrc source % " Auto load .vimrc if it changes
set runtimepath+=~/.vim/notes

"}}}
" GUI options {{{
"---------------------------------------------------------
if has("gui_running")
    set guioptions+=a       " autoselect to system clipboard *
    set guioptions-=T       " remove toolbar
    set guioptions-=r       " remove R scrollbar
    set guioptions-=L       " remove L scrollbar
    set guifont=fixed:h9:cANSI
endif

"}}}
" formatoptions {{{
"---------------------------------------------------------
set formatoptions=
silent! set formatoptions+=j   " sensibly remove comment chars on joining lines
set formatoptions+=q   " allow gq to format comments
set formatoptions+=l   " long lines not broken in insert mode
set formatoptions+=n   " recognise numbered lists when formatting
                       "   needs autoindent set, and uses formatlistpat
set formatoptions+=o   " add comment leader with o or O
set formatoptions+=r   " add comment leader on <Enter> in insert mode

"}}}
" status line and fillchars {{{
"---------------------------------------------------------
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

"}}}
" Mappings {{{
"-------------------------------------------------------
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
noremap <c-w>h <c-w>h<esc>:echoerr '^h to move left split'<CR>
noremap <c-w>j <c-w>j<esc>:echoerr '^j to move right split'<CR>
noremap <c-w>k <c-w>k<esc>:echoerr '^k to move up split'<CR>
noremap <c-w>l <c-w>l<esc>:echoerr '^l to move down split'<CR>

" indent visual block without losing selection
vnoremap < <gv
vnoremap > >gv

" Leader mappings
"-----------------------------------------------------
" Rebind <Leader> key
"let mapleader = "\\"

" Cycle tabs
" Commented out because I am trying to use buffers instead of tabs.
"map <Leader>h <esc>:tabprevious<CR>
"map <Leader>l <esc>:tabnext<CR>

" Cycle buffers
map <Leader>h <esc>:bp<CR>
map <Leader>l <esc>:bn<CR>

" Annoying messages until I get the new mapping
"noremap gT gT<esc>:echoerr '\h to move to left tab'<CR>
"noremap gt gt<esc>:echoerr '\l to move to right tab'<CR>

" sort
vnoremap <Leader>s :sort<CR>

" move to next non-blank in column
nnoremap <leader>j m':exec '/\%' . col(".") . 'c\S'<CR>``n
nnoremap <leader>k m':exec '?\%' . col(".") . 'c\S'<CR>``n
vnoremap <leader>j m':exec '/\%' . col(".") . 'c\S'<CR>``n
vnoremap <leader>k m':exec '?\%' . col(".") . 'c\S'<CR>``n

" avoid reaching for esc in insert mode
":inoremap jj <Esc>
":inoremap jk <Esc>
":inoremap kj <Esc>
":inoremap kk <Esc>

"}}}
" cursorline (disabled) {{{
"---------------------------------------------------------
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

"}}}
" vim:foldmethod=marker:foldlevel=1
