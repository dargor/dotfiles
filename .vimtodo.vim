augroup vimrc_todo
    autocmd!
    autocmd Syntax * syntax match MyTodo /\v<(BUG|HACK|FIXME|TODO|XXX)\v>/ containedin=.*Comment.*
augroup END

highlight default link MyTodo Todo
