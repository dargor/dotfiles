set nocompatible

set background=dark
silent! colorscheme selenized_bw

set autoindent
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
set scrolloff=5
set shiftround
set shiftwidth=4
set showcmd
set signcolumn=yes
set smartcase
set smarttab
set swapsync=
set tabpagemax=99
set title
set ttyfast
set updatetime=100
set viminfo=
set virtualedit=block
set wildmenu
set wildmode=list:longest,full

set nomodeline
set secure

set encoding=utf8
set t_BE=

let g:netrw_dirhistmax = 0

let g:gruvbox_contrast_dark = 'hard'
let g:gruvbox_contrast_light = 'hard'

let g:rainbow_active = 1

let g:python_highlight_all = 1
let g:python_highlight_file_headers_as_comments = 1

let g:gitgutter_diff_args = '-w'
let g:gitgutter_map_keys = 0
let g:gitgutter_max_signs = -1

if &t_Co > 2

    syntax on
    set hlsearch

    autocmd BufNewFile,BufRead *.hy set filetype=lisp
    autocmd BufNewFile,BufRead *.pp set filetype=ruby
    autocmd BufNewFile,BufRead Jenkinsfile set filetype=groovy
    autocmd BufNewFile,BufRead master,roster,*.sls set filetype=yaml
    autocmd BufNewFile,BufRead package.{env,provided} set filetype=gentoo-package-use
    autocmd BufNewFile,BufRead *.{cfg,cnf,coveragerc,service,timer,toml},cqlshrc,{krb5,supervisord}.conf set filetype=dosini

    autocmd FileType ruby,eruby,xml,yaml,json,markdown set shiftwidth=2 softtabstop=2
    autocmd FileType make set noexpandtab shiftwidth=8
    autocmd FileType gitcommit set nowrap

    if !&diff

        set colorcolumn=77

        if &t_Co >= 256
            autocmd BufEnter,WinEnter * set cursorline cursorcolumn
            autocmd BufLeave,WinLeave * set nocursorline nocursorcolumn
        endif

        function! SetupHighlights()

            highlight ColorColumn cterm=None ctermbg=Red

            highlight WhiteSpaces cterm=None ctermfg=Black ctermbg=Red
            highlight DoNotUseLogging cterm=None ctermfg=Black ctermbg=Magenta

            highlight SignColumn ctermbg=None
            highlight GitGutterAdd ctermfg=DarkGreen
            highlight GitGutterChange ctermfg=DarkYellow
            highlight GitGutterDelete ctermfg=DarkRed
            highlight GitGutterChangeDelete ctermfg=DarkMagenta

            if &t_Co >= 256

                if &background ==# 'dark'

                    highlight CursorLine cterm=None ctermbg=235
                    highlight CursorColumn cterm=None ctermbg=235

                    highlight LineNr cterm=None ctermfg=DarkGray ctermbg=None
                    highlight CursorLineNr cterm=None ctermfg=Gray ctermbg=235

                    let g:rainbow_conf = {'ctermfgs': ['lightblue', 'lightyellow', 'lightcyan', 'lightmagenta']}

                else

                    highlight CursorLine cterm=None ctermbg=255
                    highlight CursorColumn cterm=None ctermbg=255

                    highlight LineNr cterm=None ctermfg=Gray ctermbg=None
                    highlight CursorLineNr cterm=None ctermfg=DarkGray ctermbg=255

                    let g:rainbow_conf = {'ctermfgs': ['darkblue', 'darkyellow', 'darkcyan', 'darkmagenta']}

                endif

                highlight FoldColumn cterm=None ctermfg=243 ctermbg=None
                highlight Folded cterm=None ctermfg=243 ctermbg=None

                highlight Visual cterm=None ctermbg=193

            endif

            highlight Todo cterm=Bold ctermfg=Red ctermbg=None

        endfunction

        autocmd ColorScheme,Syntax * call SetupHighlights()

        function! SetupBuffer()

            if !exists('w:WhiteSpaces')
                if !hlexists('WhiteSpaces')
                    call SetupHighlights()
                endif
                let w:WhiteSpaces=matchadd('WhiteSpaces', '\(\t\|\s\+$\)')
            endif

            if !exists('w:DoNotUseLogging')
                if !hlexists('DoNotUseLogging')
                    call SetupHighlights()
                endif
                let w:DoNotUseLogging=matchadd('DoNotUseLogging', 'logging')
            endif

        endfunction

        autocmd BufEnter,WinEnter * call SetupBuffer()

    endif

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

nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

nnoremap <C-W>o :call MaximizeToggle()<CR>
nnoremap <C-W>O :call MaximizeToggle()<CR>
nnoremap <C-W><C-O> :call MaximizeToggle()<CR>

filetype plugin indent on
