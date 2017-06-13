set nocompatible

set autoindent
set background=light
set backspace=indent,start,eol
set display=lastline,uhex
set errorbells
set foldenable
set foldlevelstart=99
set foldmethod=indent
set ignorecase
set incsearch
set infercase
set mouse=
set nofsync
set number
set report=0
set ruler
set shiftround
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
	set cursorline
	set cursorcolumn
	"set colorcolumn=80
endif

set lazyredraw
set nomodeline
set secure

set encoding=utf8

" mkdir .vim && cd .vim && git clone git@github.com:luochen1990/rainbow.git .
let g:rainbow_active = 1
" also, you may want git@github.com:ervandew/supertab.git

let g:netrw_dirhistmax = 0

if &t_Co > 2
	syntax on
	set hlsearch
	filetype plugin indent on
	autocmd BufNewFile,BufRead *.hy set filetype=lisp
	autocmd BufNewFile,BufRead master,roster,*.sls set filetype=yaml
	autocmd BufNewFile,BufRead *.cnf,*.timer,*.service set filetype=dosini
	if !&diff
		autocmd FileType python setlocal colorcolumn=80
		autocmd FileType lisp,erlang setlocal expandtab|setlocal colorcolumn=80
		autocmd FileType sql,php,twig,javascript,yaml setlocal expandtab|setlocal shiftwidth=4
		autocmd FileType lua setlocal expandtab|setlocal shiftwidth=2
		"autocmd Syntax * let w:m1=matchadd('ErrorMsg', '\%>80v.\+')
		"autocmd Syntax * let w:m2=matchadd('ErrorMsg', '\t{')
		autocmd Syntax * let w:m3=matchadd('ErrorMsg', '\(\t\|\s\+$\)')
	endif
	if &t_Co > 16
		highlight CursorLine cterm=None ctermbg=234
		highlight CursorColumn cterm=None ctermbg=234
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
