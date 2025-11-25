augroup vimrc_todo
    autocmd!
    autocmd Syntax * syntax match MyTodo /\v<(TODO|WIP|MAYBE|INFO|NOTE|XXX|DOCS|PERF|TEST|ERROR|FIXME|BUG|WARN|HACK|WARNING|FIX)\v>/ containedin=.*Comment.*
augroup END

highlight default link MyTodo Todo
