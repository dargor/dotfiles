if !g:dargor_full_moumoute
    finish
endif

function! s:lumos()
    silent let g:terminal_background = trim(system('lumos'))
    if g:terminal_background ==# 'light'
        if g:colors_name !=# 'catppuccin_latte'
            colorscheme catppuccin_latte
        endif
    elseif g:terminal_background ==# 'dark'
        if g:colors_name !=# 'catppuccin_frappe'
            colorscheme catppuccin_frappe
        endif
    else
        if g:colors_name !=# 'blue'
            colorscheme blue
        endif
    endif
endfunction

autocmd FocusGained * call s:lumos()
