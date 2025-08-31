set nocompatible
set termguicolors

try
    colorscheme catppuccin_latte
    let g:dargor_full_moumoute = 1
catch
    let g:dargor_full_moumoute = 0
endtry

if &diff
    let g:dargor_full_moumoute = 0
endif

set autoindent
set background=light
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
    if &columns >= 86
        set number
        set signcolumn=yes
    endif
endif

let g:netrw_dirhistmax = 0

let g:rainbow_active = 1
let g:rainbow_conf = {}
let g:rainbow_conf.ctermfgs = ['blue', 'yellow', 'green', 'magenta']

let g:python_highlight_all = 1
let g:python_highlight_file_headers_as_comments = 1

let g:gitgutter_diff_args = '-w'
let g:gitgutter_map_keys = 0
let g:gitgutter_max_signs = -1
let g:gitgutter_sign_allow_clobber = 1

let g:vim_ai_chat_markdown = 1

let g:llama_config = #{
\   endpoint: 'http://localhost:1336/infill',
\   max_line_suffix: 80,
\   show_info: v:false,
\ }

if &t_Co > 2

    syntax on
    set hlsearch

    if !&diff
        set colorcolumn=80
    endif

    function! SetupHighlights()
        " :h highlight-groups
        " :so $VIMRUNTIME/syntax/hitest.vim
        highlight WhiteSpaces ctermbg=Red

        highlight clear LspHintText
        highlight link LspHintText Ignore
        highlight clear LspHintVirtualText
        highlight link LspHintVirtualText Ignore

        highlight clear LspInformationText
        highlight link LspInformationText Ignore
        highlight clear LspInformationVirtualText
        highlight link LspInformationVirtualText Ignore

        highlight clear LspWarningText
        highlight link LspWarningText Todo
        highlight clear LspWarningVirtualText
        highlight link LspWarningVirtualText Todo

        highlight clear LspErrorText
        highlight link LspErrorText Error
        highlight clear LspErrorVirtualText
        highlight link LspErrorVirtualText Error

        highlight clear LspHintHighlight
        highlight link LspHintHighlight Ignore

        highlight clear LspInformationHighlight
        highlight link LspInformationHighlight Ignore

        highlight clear LspWarningHighlight
        highlight link LspWarningHighlight Todo

        highlight clear LspErrorHighlight
        highlight link LspErrorHighlight Error

        highlight clear lspInlayHintsType
        highlight link lspInlayHintsType Ignore

        highlight clear lspInlayHintsParameter
        highlight link lspInlayHintsParameter Ignore

        if index(['man', 'aichat'], &filetype) >= 0
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

nnoremap fj :%!jq .<CR>
nnoremap fJ :%!jq -S .<CR>

nnoremap <F4> :Lexplore<CR>
nnoremap <F5> :syntax sync fromstart<CR>
nnoremap <F6> :set invpaste paste?<CR>
nnoremap <F7> :call ToggleMouse()<CR>
nnoremap <F8> :setlocal cursorcolumn!<CR>
nnoremap <F9> :!%:p<CR>

nnoremap <C-W>o :call MaximizeToggle()<CR>
nnoremap <C-W>O :call MaximizeToggle()<CR>
nnoremap <C-W><C-O> :call MaximizeToggle()<CR>

filetype plugin indent on

autocmd FileType rust setlocal matchpairs+=<:> | syntax keyword Keyword async await
autocmd FileType ruby,eruby,xml,yaml,json,markdown setlocal shiftwidth=2 softtabstop=2
autocmd FileType make setlocal noexpandtab shiftwidth=8
autocmd FileType markdown setlocal formatoptions-=tc
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
