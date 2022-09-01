set nocompatible

try
    set background=dark
    colorscheme selenized_bw
    let g:dargor_full_moumoute = 1
catch
    set background=light
    let g:dargor_full_moumoute = 0
endtry

if &diff
    let g:dargor_full_moumoute = 0
endif

set autoindent
set backspace=indent,start,eol
set diffopt=internal,filler,iwhiteall
set display=lastline,uhex
set errorbells
set expandtab
set foldenable
set foldlevelstart=99
set foldmethod=indent
set formatoptions=croqj
set ignorecase
set incsearch
set infercase
set mouse=
set noequalalways
set nofsync
set nojoinspaces
set report=0
set ruler
set scrolloff=5
set shiftround
set shiftwidth=4
set showcmd
set smartcase
set smarttab
set swapsync=
set tabpagemax=99
set textwidth=79
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

if &columns >= 86 && g:dargor_full_moumoute
    set number
    set signcolumn=yes
endif

if g:dargor_full_moumoute
    let g:light_color_column = 224
    let g:dark_color_column = 52
else
    let g:light_color_column = 1
    let g:dark_color_column = 9
endif

let g:netrw_dirhistmax = 0

let g:gruvbox_contrast_dark = 'hard'
let g:gruvbox_contrast_light = 'hard'

let g:rainbow_active = 1
let g:rainbow_conf = {}

let g:python_highlight_all = 1
let g:python_highlight_file_headers_as_comments = 1

let g:gitgutter_diff_args = '-w'
let g:gitgutter_map_keys = 0
let g:gitgutter_max_signs = -1
let g:gitgutter_sign_allow_clobber = 1

let g:indent_guides_auto_colors = 0
let g:indent_guides_enable_on_vim_startup = 1

if &t_Co > 2

    syntax on
    set hlsearch
    set colorcolumn=80

    autocmd BufNewFile,BufRead *.hy,*.lfe setlocal filetype=lisp
    autocmd BufNewFile,BufRead *.pp setlocal filetype=ruby
    autocmd BufNewFile,BufRead *.{tf,tfvars} setlocal filetype=terraform syntax=hcl
    autocmd BufNewFile,BufRead *.tfstate setlocal filetype=json
    autocmd BufNewFile,BufRead Jenkinsfile setlocal filetype=groovy
    autocmd BufNewFile,BufRead Dockerfile.* setlocal filetype=dockerfile
    autocmd BufNewFile,BufRead master,roster,*.sls setlocal filetype=yaml
    autocmd BufNewFile,BufRead package.{env,provided} setlocal filetype=gentoo-package-use
    autocmd BufNewFile,BufRead *.{cfg,cnf,coveragerc,service,timer,toml},cqlshrc,{krb5,supervisord}.conf setlocal filetype=dosini
    autocmd BufNewFile,BufRead *.cql setlocal filetype=sql
    autocmd BufNewFile,BufRead *.bats setlocal filetype=sh

    " pyx (implementation) and pxd (definition) are handled, but pxi (include) are not
    autocmd BufNewFile,BufRead *.pxi setlocal filetype=pyrex

    autocmd FileType rust setlocal matchpairs+=<:>
    autocmd FileType ruby,eruby,xml,yaml,json,markdown setlocal shiftwidth=2 softtabstop=2
    autocmd FileType make setlocal noexpandtab shiftwidth=8
    autocmd FileType gitcommit setlocal nowrap

    if g:dargor_full_moumoute
        autocmd FileType cmake RainbowToggleOff
    endif

    function! HelmSyntax()
        setlocal filetype=yaml
        unlet b:current_syntax
        syntax include @GO syntax/go.vim
        let b:current_syntax = 'yaml'
        syntax region goTxt matchgroup=goTpl start=/{{\(-\)\?/ end=/\(-\)\?}}/ contains=@GO containedin=ALLBUT,goTxt
        highlight link goTpl PreProc
    endfunction

    autocmd BufNewFile,BufRead */templates/*.yaml,*/templates/*.tpl call HelmSyntax()

    function! SetupHighlights()
        highlight Directory ctermfg=Blue
        highlight NonText ctermfg=DarkBlue
        highlight SpecialKey ctermfg=DarkRed
        highlight WhiteSpaces cterm=None ctermfg=Black ctermbg=Red
        highlight DoNotUseLogging cterm=None ctermfg=Black ctermbg=Magenta
        highlight SignColumn ctermbg=None
        highlight GitGutterAdd ctermfg=DarkGreen
        highlight GitGutterChange ctermfg=DarkYellow
        highlight GitGutterDelete ctermfg=DarkRed
        highlight GitGutterChangeDelete ctermfg=DarkMagenta
        if &t_Co >= 256
            if &background ==# 'dark'
                execute 'highlight ColorColumn ctermbg=' . g:dark_color_column
                highlight LineNr cterm=None ctermfg=DarkGray ctermbg=None
                highlight IndentGuidesOdd ctermbg=237
                highlight IndentGuidesEven ctermbg=239
                let g:rainbow_conf.ctermfgs = ['lightblue', 'lightyellow', 'lightcyan', 'lightmagenta']
            else
                execute 'highlight ColorColumn ctermbg=' . g:light_color_column
                highlight LineNr cterm=None ctermfg=Gray ctermbg=None
                highlight IndentGuidesOdd ctermbg=251
                highlight IndentGuidesEven ctermbg=253
                let g:rainbow_conf.ctermfgs = ['darkblue', 'darkyellow', 'darkcyan', 'darkmagenta']
            endif
            highlight FoldColumn cterm=None ctermfg=243 ctermbg=None
            highlight Folded cterm=None ctermfg=243 ctermbg=None
            highlight Visual cterm=None ctermbg=193
        endif
        highlight Todo cterm=Bold ctermfg=Red ctermbg=None
        highlight DiffFile cterm=None ctermfg=DarkMagenta ctermbg=None
        highlight DiffAdded cterm=None ctermfg=DarkGreen ctermbg=None
        highlight DiffRemoved cterm=None ctermfg=DarkRed ctermbg=None
        highlight DiffAdd cterm=None ctermfg=Black ctermbg=Green
        highlight DiffChange cterm=None ctermfg=Black ctermbg=Yellow
        highlight DiffDelete cterm=None ctermfg=Black ctermbg=Red
        highlight DiffText cterm=None ctermfg=Black ctermbg=Magenta
    endfunction

    autocmd ColorScheme,Syntax * call SetupHighlights()

    function! InitBuffer()
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

    function! EnterBuffer()
        call InitBuffer()
        if g:dargor_full_moumoute
            setlocal cursorline
            "setlocal cursorcolumn
        endif
    endfunction

    function! LeaveBuffer()
        if g:dargor_full_moumoute
            setlocal nocursorline
            "setlocal nocursorcolumn
        endif
    endfunction

    autocmd BufWinEnter * call InitBuffer()
    autocmd BufEnter,WinEnter * call EnterBuffer()
    autocmd BufLeave,WinLeave * call LeaveBuffer()

endif

function! ToggleBackground()
    let oldsyn = &syntax
    if &background ==# 'dark'
        set background=light
    else
        set background=dark
    endif
    try
        filetype detect
    catch
        " some plugins generate errors here, just ignore them
    endtry
    let &syntax = oldsyn
    if &syntax ==# 'yaml'
        call HelmSyntax()
    endif
endfunction

function! MaximizeToggle()
    if exists('s:maximize_session')
        silent! execute 'source ' . s:maximize_session
        call delete(s:maximize_session)
        unlet s:maximize_session
        let &hidden=s:maximize_hidden_save
        unlet s:maximize_hidden_save
    else
        let s:maximize_hidden_save = &hidden
        let s:maximize_session = tempname()
        setlocal hidden
        execute 'mksession! ' . s:maximize_session
        only
    endif
endfunction

function! ToggleMouse()
    if empty(&mouse)
        set mouse=a
        echo '  mouse'
    else
        set mouse=
        echo 'nomouse'
    endif
endfunction

nnoremap <space> za
nnoremap zC :setlocal foldlevel=0<CR>
nnoremap zO :setlocal foldlevel=99<CR>

nnoremap SE :setlocal spell spelllang=en<CR>
nnoremap SF :setlocal spell spelllang=fr<CR>
nnoremap SB :setlocal spell spelllang=en,fr<CR>
nnoremap SN :setlocal nospell<CR>

nnoremap <F5> :syntax sync fromstart<CR>
nnoremap <F6> :set invpaste paste?<CR>
nnoremap <F7> :call ToggleMouse()<CR>
nnoremap <F9> :!%:p<CR>

nnoremap <C-b> :call ToggleBackground()<CR>

nnoremap <C-W>o :call MaximizeToggle()<CR>
nnoremap <C-W>O :call MaximizeToggle()<CR>
nnoremap <C-W><C-O> :call MaximizeToggle()<CR>

filetype plugin indent on
