augroup vimrc_gitconflicts
    autocmd!
    autocmd Syntax * syntax match GitConflicts /^\(<<<<<<<\|=======\|>>>>>>>\).*/
augroup END

highlight default link GitConflicts SpellBad
