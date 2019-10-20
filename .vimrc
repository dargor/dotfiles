set nocompatible
filetype off

set autoindent
set background=light
set backspace=indent,start,eol
set diffopt=internal,filler,iwhiteall
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
set title
set updatetime=100
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

set nomodeline
set secure

set encoding=utf8
set t_BE=

let g:rainbow_active = 1
let g:netrw_dirhistmax = 0
let g:gitgutter_map_keys = 0
let g:gitgutter_max_signs = 1024
let g:gitgutter_override_sign_column_highlight = 0
highlight SignColumn ctermbg=None
highlight GitGutterAdd ctermfg=10
highlight GitGutterChange ctermfg=11
highlight GitGutterDelete ctermfg=9
highlight GitGutterChangeDelete ctermfg=13

if &t_Co > 2

    syntax on
    set hlsearch

    autocmd BufNewFile,BufRead *.hy set filetype=lisp
    autocmd BufNewFile,BufRead *.pp set filetype=ruby
    autocmd BufNewFile,BufRead *.tf set filetype=conf
    autocmd BufNewFile,BufRead Jenkinsfile set filetype=groovy
    autocmd BufNewFile,BufRead master,roster,*.sls set filetype=yaml
    autocmd BufNewFile,BufRead package.{env,provided} set filetype=gentoo-package-use
    autocmd BufNewFile,BufRead *.cnf,*.timer,*.service,*.toml set filetype=dosini

    autocmd FileType ruby,eruby,xml,yaml,json,markdown set shiftwidth=2 softtabstop=2
    autocmd FileType make set noexpandtab shiftwidth=8
    autocmd FileType gitcommit set nowrap

    if !&diff

        autocmd BufEnter,WinEnter * set cursorline cursorcolumn
        autocmd BufLeave,WinLeave * set nocursorline nocursorcolumn

        highlight WhiteSpaces cterm=None ctermfg=Black ctermbg=Red
        autocmd Syntax * let w:m3=matchadd('WhiteSpaces', '\(\t\|\s\+$\)')

        highlight DoNotUseLogging cterm=None ctermfg=Black ctermbg=Red
        autocmd Syntax * let w:m4=matchadd('DoNotUseLogging', 'logging')

    endif

    if &t_Co > 16

        highlight CursorLine cterm=None ctermbg=235
        highlight CursorColumn cterm=None ctermbg=235

        highlight ColorColumn cterm=None ctermbg=196

        highlight FoldColumn cterm=None ctermfg=243 ctermbg=None
        highlight Folded cterm=None ctermfg=243 ctermbg=None

        highlight Visual cterm=None ctermbg=193

    else

        set nocursorline
        set nocursorcolumn

    endif

    highlight Todo cterm=Bold ctermfg=Red ctermbg=None

    highlight LineNr cterm=Bold ctermfg=Yellow ctermbg=Blue
    highlight CursorLineNr cterm=Bold ctermfg=Green ctermbg=DarkBlue

    highlight DiffAdd cterm=None ctermfg=Black ctermbg=Green
    highlight DiffChange cterm=None ctermfg=Black ctermbg=Yellow
    highlight DiffDelete cterm=None ctermfg=Black ctermbg=Red
    highlight DiffText cterm=None ctermfg=Black ctermbg=Magenta

endif

function! MaximizeToggle()
    if exists('s:maximize_session')
        exec 'source ' . s:maximize_session
        call delete(s:maximize_session)
        unlet s:maximize_session
        let &hidden=s:maximize_hidden_save
        unlet s:maximize_hidden_save
    else
        let s:maximize_hidden_save = &hidden
        let s:maximize_session = tempname()
        set hidden
        exec 'mksession! ' . s:maximize_session
        only
    endif
endfunction

nnoremap <space> za

nnoremap <C-W>o :call MaximizeToggle()<CR>
nnoremap <C-W>O :call MaximizeToggle()<CR>
nnoremap <C-W><C-O> :call MaximizeToggle()<CR>

filetype plugin indent on
