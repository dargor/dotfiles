set hidden

function! s:read_gitignore(fname)
    if filereadable(a:fname)
        return join(map(split(system("grep -Ev '^(#|$)' < " . a:fname), '\n'), "'^' .. substitute(substitute(v:val, '[~,\\.]', '\\\\&', 'g'), '*', '.*', 'g') .. '$'"), ',')
    else
        return ''
    endif
endfunction

let g:netrw_banner = 0
let g:netrw_browse_split = 4
let g:netrw_fastbrowse = 0
let g:netrw_list_hide = join([s:read_gitignore(expand('~/.gitignore')), s:read_gitignore('.gitignore'), '^\.git/$'], ',')
let g:netrw_liststyle = 3
let g:netrw_sort_by = 'name'
let g:netrw_sort_direction = 'normal'
let g:netrw_special_syntax= 1
let g:netrw_winsize = -32

if g:dargor_full_moumoute
    if &columns >= 119
        if index(['gitcommit', 'gitrebase'], &filetype) == -1
            if get(v:argv, -1, '') !=# '-'
                if argc() == 0
                    autocmd VimEnter * ++once Lexplore
                elseif argc() == 1
                    autocmd VimEnter * ++once Lexplore | wincmd p
                endif
            endif
        endif
    endif
endif
