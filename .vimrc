set nocompatible
set notermguicolors

try
    set background=dark
    colorscheme selenized_bw
    let g:dargor_full_moumoute = 1
catch
    set background=light
    let g:dargor_full_moumoute = 0
endtry

if &diff
    if g:dargor_full_moumoute
        colorscheme iceberg
    endif
    let g:dargor_full_moumoute = 0
endif

set autoindent
set backspace=indent,start,eol
set diffopt=filler,iwhiteall
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
set regexpengine=2
set report=0
set ruler
set scrolloff=5
set shiftround
set shiftwidth=4
set showcmd
set smartcase
set smarttab
set tabpagemax=99
set textwidth=79
set title
set ttyfast
set updatetime=100
set viminfo=
set virtualedit=block
set wildmenu
set wildmode=list:longest,full

if exists('&swapsync')
    set swapsync=
endif

set nomodeline
set secure

set encoding=utf8
set t_BE=

if g:dargor_full_moumoute
    if !empty($JUPYTER_SERVER_ROOT)
        set background=light
        set mouse=a
    endif
    if $TERM_PROGRAM ==# 'vscode'
        set background=dark
        set mouse=a
    endif
    if &columns >= 86
        set number
        set signcolumn=yes
    endif
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

if &t_Co > 2

    syntax on
    set hlsearch

    if !&diff
        set colorcolumn=80
    endif

    function! SetupHighlights()
        " :h highlight-groups
        " :so $VIMRUNTIME/syntax/hitest.vim
        highlight clear Comment
        highlight Comment ctermfg=243
        highlight Directory ctermfg=Blue
        highlight NonText ctermfg=DarkBlue
        highlight SpecialKey ctermfg=DarkRed
        highlight WhiteSpaces ctermbg=Red
        if &t_Co >= 256
            if &background ==# 'dark'
                execute 'highlight ColorColumn ctermbg=' . g:dark_color_column
                let g:rainbow_conf.ctermfgs = ['blue', 'yellow', 'cyan', 'magenta']
                highlight GitGutterAdd ctermfg=Green
                highlight GitGutterChange ctermfg=Yellow
                highlight GitGutterDelete ctermfg=Red
                highlight GitGutterChangeDelete ctermfg=Magenta
                highlight Pmenu ctermfg=244 ctermbg=235
                highlight LspHintText ctermfg=243
                highlight LspHintVirtualText ctermfg=243
                highlight LspInformationText ctermfg=243
                highlight LspInformationVirtualText ctermfg=243
                highlight LspWarningText ctermfg=Yellow
                highlight LspWarningVirtualText ctermfg=Yellow
                highlight LspErrorText ctermfg=Red
                highlight LspErrorVirtualText ctermfg=Red
                highlight lspInlayHintsType ctermfg=240
                highlight lspInlayHintsParameter ctermfg=135
            else
                execute 'highlight ColorColumn ctermbg=' . g:light_color_column
                let g:rainbow_conf.ctermfgs = ['darkblue', 'darkyellow', 'darkcyan', 'darkmagenta']
                highlight GitGutterAdd ctermfg=40
                highlight GitGutterChange ctermfg=208
                highlight GitGutterDelete ctermfg=Red
                highlight GitGutterChangeDelete ctermfg=Magenta
                highlight Pmenu ctermfg=242 ctermbg=255
                highlight LspHintText ctermfg=243
                highlight LspHintVirtualText ctermfg=243
                highlight LspInformationText ctermfg=243
                highlight LspInformationVirtualText ctermfg=243
                highlight LspWarningText ctermfg=208
                highlight LspWarningVirtualText ctermfg=208
                highlight LspErrorText ctermfg=Red
                highlight LspErrorVirtualText ctermfg=Red
                highlight lspInlayHintsType ctermfg=250
                highlight lspInlayHintsParameter ctermfg=129
            endif
            highlight lspReference ctermfg=Magenta ctermbg=Yellow
            highlight FoldColumn ctermfg=243
            highlight Folded ctermfg=243
        endif
        highlight Todo ctermfg=Red
        highlight MoreMsg ctermfg=DarkYellow
        highlight ErrorMsg ctermfg=Red
        highlight DiffFile ctermfg=DarkMagenta
        highlight DiffAdded ctermfg=DarkGreen
        highlight DiffRemoved ctermfg=DarkRed
        highlight DiffText ctermfg=Black ctermbg=Magenta
        if &filetype ==# 'man'
            " vimmanpager
            setlocal nonumber
            setlocal colorcolumn=
            setlocal signcolumn=no
            highlight clear WhiteSpaces
        endif
    endfunction

    autocmd ColorScheme,Syntax * call SetupHighlights()

    function! InitBuffer()
        if !exists('w:WhiteSpaces')
            if !hlexists('WhiteSpaces')
                call SetupHighlights()
            endif
            let w:WhiteSpaces=matchadd('WhiteSpaces', '\(\t\|\s\+$\)')
        endif
    endfunction

    function! EnterBuffer()
        call InitBuffer()
        if g:dargor_full_moumoute
            setlocal cursorline
            if index(['yaml', 'json'], &syntax) >= 0
                setlocal cursorcolumn
            endif
        endif
    endfunction

    function! LeaveBuffer()
        if g:dargor_full_moumoute
            setlocal nocursorline
            setlocal nocursorcolumn
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
        if g:dargor_full_moumoute
            call HelmSyntax()
        endif
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

function! WFlake()
    execute 'term ++kill=term wflake8 ' . expand('%:p')
    resize 11
    wincmd p
endfunction

function! WShell()
    execute 'term ++kill=term wshellcheck ' . expand('%:p')
    resize 11
    wincmd p
endfunction

function! WYaml()
    execute 'term ++kill=term wyamllint ' . expand('%:p')
    resize 11
    wincmd p
endfunction

nnoremap <space> za
nnoremap zC :setlocal foldlevel=0<CR>
nnoremap zO :setlocal foldlevel=99<CR>

nnoremap SE :setlocal spell spelllang=en<CR>
nnoremap SF :setlocal spell spelllang=fr<CR>
nnoremap SB :setlocal spell spelllang=en,fr<CR>
nnoremap SN :setlocal nospell<CR>

nnoremap WF :call WFlake()<CR>
nnoremap WS :call WShell()<CR>
nnoremap WY :call WYaml()<CR>

nnoremap <F4> :Lexplore<CR>
nnoremap <F5> :syntax sync fromstart<CR>
nnoremap <F6> :set invpaste paste?<CR>
nnoremap <F7> :call ToggleMouse()<CR>
nnoremap <F8> :setlocal cursorcolumn!<CR>
nnoremap <F9> :!%:p<CR>

nnoremap <C-b> :call ToggleBackground()<CR>

nnoremap <C-W>o :call MaximizeToggle()<CR>
nnoremap <C-W>O :call MaximizeToggle()<CR>
nnoremap <C-W><C-O> :call MaximizeToggle()<CR>

filetype plugin indent on

autocmd FileType rust setlocal matchpairs+=<:> | syntax keyword Keyword async await
autocmd FileType ruby,eruby,xml,yaml,json,markdown setlocal shiftwidth=2 softtabstop=2
autocmd FileType make setlocal noexpandtab shiftwidth=8
autocmd FileType gitcommit setlocal nowrap
if g:dargor_full_moumoute
    autocmd FileType cmake RainbowToggleOff
endif

cnoreabbrev t terminal
cnoreabbrev vt vertical terminal
autocmd TerminalOpen * setlocal nonumber signcolumn=no colorcolumn=

for f in split(expand('~/.vim*.vim'), '\n')
    if filereadable(f)
        execute 'source ' . f
    endif
endfor
