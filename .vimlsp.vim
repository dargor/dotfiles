let g:lsp_max_buffer_size = -1
let g:lsp_use_native_client = 1

let g:lsp_diagnostics_echo_cursor = 1
let g:lsp_diagnostics_echo_delay = 200
let g:lsp_diagnostics_highlights_delay = 200
let g:lsp_diagnostics_signs_delay = 200
" Signs placed by other plugins have a priority of 10 by default.
let g:lsp_diagnostics_signs_priority = 11
let g:lsp_diagnostics_virtual_text_enabled = 0

" Using BufWritePre to execute sync commands may cause vim to hang with
" some language servers, as starting the language server may be slow.
let g:lsp_format_sync_timeout = 1000

let g:lsp_document_code_action_signs_delay = 200
" https://github.com/prabirshrestha/vim-lsp/issues/1399
let g:lsp_document_highlight_enabled = 0

let g:lsp_inlay_hints_enabled = 1
let g:lsp_inlay_hints_delay = 200

let g:lsp_signature_help_enabled = 1
let g:lsp_signature_help_delay = 200

if executable('pylsp')
    " https://github.com/python-lsp/python-lsp-server#configuration
    autocmd User lsp_setup call lsp#register_server(#{
    \   name: 'Python Language Server',
    \   cmd: {server_info->['pylsp']},
    \   allowlist: ['python'],
    \   workspace_config: #{
    \     pylsp: #{
    \       configurationSources: ['flake8'],
    \       plugins: #{
    \         autopep8: #{
    \           enabled: v:false,
    \         },
    \         flake8: #{
    \           enabled: v:true,
    \         },
    \         mccabe: #{
    \           enabled: v:false,
    \         },
    \         pycodestyle: #{
    \           enabled: v:false,
    \         },
    \         pydocstyle: #{
    \           enabled: v:false,
    \         },
    \         pyflakes: #{
    \           enabled: v:false,
    \         },
    \         pylint: #{
    \           enabled: v:false,
    \         },
    \         yapf: #{
    \           enabled: v:false,
    \         },
    \       },
    \     },
    \   },
    \ })
endif

if executable('rust-analyzer')
    " https://rust-analyzer.github.io/manual.html#configuration
    autocmd User lsp_setup call lsp#register_server(#{
    \   name: 'Rust Language Server',
    \   cmd: {server_info->['rust-analyzer']},
    \   allowlist: ['rust'],
    \   initialization_options: #{
    \     cargo: #{
    \       buildScripts: #{
    \         enable: v:false,
    \       },
    \     },
    \     inlayHints: #{
    \       closingBraceHints: #{
    \         minLines: 0,
    \       },
    \       maxLength: v:null,
    \     },
    \     procMacro: #{
    \       enable: v:false,
    \     },
    \   },
    \ })
endif

function! s:on_lsp_buffer_enabled() abort
    setlocal signcolumn=yes
    setlocal omnifunc=lsp#complete
    setlocal tagfunc=lsp#tagfunc
    nmap <buffer> ga <plug>(lsp-code-action-float)
    nmap <buffer> gd <plug>(lsp-definition)
    nmap <buffer> gD <plug>(lsp-document-diagnostics)
    nmap <buffer> gs <plug>(lsp-document-symbol-search)
    nmap <buffer> gS <plug>(lsp-workspace-symbol-search)
    nmap <buffer> gr <plug>(lsp-references)
    nmap <buffer> gi <plug>(lsp-implementation)
    nmap <buffer> td <plug>(lsp-type-definition)
    nmap <buffer> th <plug>(lsp-type-hierarchy)
    nmap <buffer> <F2> <plug>(lsp-rename)
    nmap <buffer> [g <plug>(lsp-previous-diagnostic)
    nmap <buffer> ]g <plug>(lsp-next-diagnostic)
    nmap <buffer> K <plug>(lsp-hover-float)
    nnoremap <buffer> <expr><c-k> lsp#scroll(-3)
    nnoremap <buffer> <expr><c-j> lsp#scroll(+3)
    autocmd! BufWritePre *.rs,*.go call execute('LspDocumentFormatSync')
endfunction

augroup lsp_install
    autocmd!
    autocmd User lsp_buffer_enabled call s:on_lsp_buffer_enabled()
augroup END
