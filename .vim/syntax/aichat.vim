if exists('b:current_syntax')
    finish
endif

runtime! syntax/markdown.vim

syntax match aichatRole ">>> system"
syntax match aichatRole ">>> user"
syntax match aichatRole ">>> include"
syntax match aichatRole "<<< assistant"

highlight default link aichatRole Comment

syntax region userInput start=/^>>>\s\+/hs=e end=/^\ze<<<\s\+/ keepend contains=aichatRole
highlight link userInput NONE

setlocal concealcursor=nc
setlocal conceallevel=3

let b:current_syntax = 'aichat'
