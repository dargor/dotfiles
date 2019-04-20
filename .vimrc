set nocompatible

set autoindent
set background=light
set backspace=indent,start,eol
set display=lastline,uhex
set errorbells
set expandtab
set foldenable
set foldlevelstart=99
set foldmethod=indent
set ignorecase
set incsearch
set infercase
set mouse=
set nofsync
set report=0
set ruler
set shiftround
set shiftwidth=4
set showcmd
set smartcase
set smarttab
set swapsync=
set tabpagemax=99
set viminfo=
set virtualedit=block
set wildmenu
set wildmode=list:longest,full

if !&diff
    "set number
    "set cursorline
    "set cursorcolumn
    set colorcolumn=80
endif

"set lazyredraw
set nomodeline
set secure

set encoding=utf8

" disable bracketed paste brainfucked mode
set t_BE=

" Makefiles are *very* picky with tabulations
if &filetype == 'make'
    set noexpandtab
endif

let g:rainbow_active = 1

let g:indentLine_char = '┆'
let g:indentLine_color_term = 239
let g:indentLine_fileTypeExclude = ['markdown', 'json']

let g:netrw_dirhistmax = 0

if &t_Co > 2
    syntax on
    set hlsearch
    filetype plugin indent on
    autocmd BufNewFile,BufRead *.hy set filetype=lisp
    autocmd BufNewFile,BufRead *.pp set filetype=ruby
    autocmd BufNewFile,BufRead *.tf set filetype=conf
    autocmd BufNewFile,BufRead Jenkinsfile set filetype=groovy
    autocmd BufNewFile,BufRead master,roster,*.sls set filetype=yaml
    autocmd BufNewFile,BufRead *.cnf,*.timer,*.service,*.toml set filetype=dosini
    autocmd BufNewFile,BufRead package.env set filetype=gentoo-package-use
    autocmd FileType ruby,eruby,xml,yaml,json,markdown set shiftwidth=2 softtabstop=2
    if !&diff
        autocmd Syntax * let w:m3=matchadd('ErrorMsg', '\(\t\|\s\+$\)')
    endif
    if &t_Co > 16
        highlight CursorLine cterm=None ctermbg=235
        highlight CursorColumn cterm=None ctermbg=235
        highlight ColorColumn cterm=None ctermbg=196
        highlight Folded cterm=None ctermfg=243 ctermbg=None
        highlight Visual cterm=None ctermbg=193
    else
        highlight CursorLine cterm=None ctermbg=None
        highlight CursorColumn cterm=None ctermbg=None
    endif
    highlight Todo cterm=Bold ctermfg=Red ctermbg=None
    highlight LineNr cterm=Bold ctermfg=Yellow ctermbg=Blue
    highlight CursorLineNr cterm=Bold ctermfg=Green ctermbg=DarkBlue
    highlight DiffAdd cterm=None ctermfg=Black ctermbg=Green
    highlight DiffChange cterm=None ctermfg=Black ctermbg=Yellow
    highlight DiffDelete cterm=None ctermfg=Black ctermbg=Red
    highlight DiffText cterm=None ctermfg=Black ctermbg=Magenta
endif
