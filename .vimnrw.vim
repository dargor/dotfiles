set hidden

let g:netrw_banner = 0
let g:netrw_browse_split = 4
let g:netrw_fastbrowse = 0
let g:netrw_list_hide = join(map(split(system("grep -Ev '^(#|$)' < ~/.gitignore"), '\n'),
    \   "'^' .. substitute(substitute(v:val, '\\.', '\\\\.', 'g'), '*', '.*', 'g') .. '$'"
    \ ), ',') . ',^\.git/$'
let g:netrw_liststyle = 3
let g:netrw_sort_by = 'name'
let g:netrw_sort_direction = 'normal'
let g:netrw_winsize = -32

if g:dargor_full_moumoute
    if &columns >= 119
        if argc() <= 1
            if &filetype !=# 'gitcommit'
                if get(v:argv, -1, '') !=# '-'
                    autocmd VimEnter * ++once Vexplore | wincmd p
                endif
            endif
        endif
    endif
endif
