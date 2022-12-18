" https://github.com/yegappan/lsp

let lspServers = [
    \   #{
    \     filetype: ['python'],
    \     path: 'pylsp',
    \     omnicompl: v:true,
    \   },
    \   #{
    \     filetype: ['rust'],
    \     path: 'rust-analyzer',
    \     omnicompl: v:true,
    \     syncInit: v:true,
    \   },
    \ ]
autocmd VimEnter * call LspAddServer(lspServers)

let lspOpts = #{
    \   autoPopulateDiags: v:true,
    \   usePopupInCodeAction: v:true,
    \ }
autocmd VimEnter * call LspOptionsSet(lspOpts)

setlocal signcolumn=yes
setlocal omnifunc=LspOmniFunc
setlocal tagfunc=lsp#lsp#TagFunc

nmap <buffer> ga :LspCodeAction<CR>
nmap <buffer> gd :LspDiagCurrent<CR>
nmap <buffer> gD :LspDiagShow<CR>
nmap <buffer> gO :LspOutline<CR>
nmap <buffer> gR :LspShowReferences<CR>
nmap <buffer> K :LspHover<CR>
