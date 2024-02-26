if &diff
    finish
endif

let g:lsp_max_buffer_size = -1
let g:lsp_use_native_client = 1

let g:lsp_diagnostics_highlights_delay = 200
let g:lsp_diagnostics_highlights_enabled = 0
let g:lsp_diagnostics_highlights_insert_mode_enabled = 0
let g:lsp_diagnostics_signs_delay = 200
let g:lsp_diagnostics_signs_insert_mode_enabled = 0
let g:lsp_diagnostics_signs_priority = 11
let g:lsp_diagnostics_virtual_text_align = "after"
let g:lsp_diagnostics_virtual_text_delay = 200
let g:lsp_diagnostics_virtual_text_insert_mode_enabled = 1
let g:lsp_diagnostics_virtual_text_prefix = "⛔ "

let g:lsp_document_code_action_signs_enabled = 0
let g:lsp_document_highlight_delay = 200

let g:lsp_inlay_hints_enabled = 1
let g:lsp_inlay_hints_delay = 200

if executable('bash-language-server')
    " https://github.com/bash-lsp/bash-language-server#vim
    autocmd User lsp_setup call lsp#register_server(#{
    \   name: 'Bash Language Server',
    \   cmd: {server_info->[&shell, &shellcmdflag, 'bash-language-server start']},
    \   allowlist: ['sh', 'bash'],
    \ })
endif

if executable('clangd')
    " https://jonasdevlieghere.com/vim-lsp-clangd/#configurevimtouseclangd
    autocmd User lsp_setup call lsp#register_server(#{
    \   name: 'C/C++ Language Server',
    \   cmd: {server_info->['clangd']},
    \   allowlist: ['c', 'cpp', 'objc', 'objcpp'],
    \ })
endif

if executable('docker-langserver')
    " https://github.com/rcjsuen/dockerfile-language-server-nodejs#installation-instructions
    autocmd User lsp_setup call lsp#register_server(#{
    \   name: 'Docker Language Server',
    \   cmd: {server_info->[&shell, &shellcmdflag, 'docker-langserver --stdio']},
    \   allowlist: ['dockerfile'],
    \ })
endif

if executable('lua-language-server')
    " https://github.com/LuaLS/lua-language-server#install
    autocmd User lsp_setup call lsp#register_server(#{
    \   name: 'Lua Language Server',
    \   cmd: {server_info->['lua-language-server']},
    \   allowlist: ['lua'],
    \ })
endif

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
    \           enabled: v:true,
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
    \     checkOnSave: #{
    \       command: "clippy",
    \     },
    \     inlayHints: #{
    \       chainingHints: #{
    \         enable: v:false,
    \       },
    \       closingBraceHints: #{
    \         minLines: 0,
    \       },
    \       maxLength: v:null,
    \     },
    \     procMacro: #{
    \       enable: v:false,
    \     },
    \     rust: #{
    \       analyzerTargetDir: v:true,
    \     },
    \   },
    \ })
endif

if executable('terraform-ls')
    " https://github.com/hashicorp/terraform-ls/blob/main/docs/USAGE.md#vim-lsp
    autocmd User lsp_setup call lsp#register_server(#{
    \   name: 'Terraform Language Server',
    \   cmd: {server_info->[&shell, &shellcmdflag, 'terraform-ls serve']},
    \   allowlist: ['terraform'],
    \ })
endif

if executable('typescript-language-server')
    " https://github.com/typescript-language-server/typescript-language-server#running-the-language-server
    autocmd User lsp_setup call lsp#register_server(#{
    \   name: 'TypeScript Language Server',
    \   cmd: {server_info->[&shell, &shellcmdflag, 'typescript-language-server --stdio']},
    \   allowlist: ['javascript', 'typescript'],
    \ })
endif

if executable('vim-language-server')
    " https://github.com/iamcco/vim-language-server#config
    autocmd User lsp_setup call lsp#register_server(#{
    \   name: 'VimScript Language Server',
    \   cmd: {server_info->[&shell, &shellcmdflag, 'vim-language-server --stdio']},
    \   allowlist: ['vim'],
    \ })
endif

"if executable('yaml-language-server')
"    " https://github.com/redhat-developer/yaml-language-server#connecting-to-the-language-server-via-stdio
"    autocmd User lsp_setup call lsp#register_server(#{
"    \   name: 'YAML Language Server',
"    \   cmd: {server_info->[&shell, &shellcmdflag, 'yaml-language-server --stdio']},
"    \   allowlist: ['yaml'],
"    \ })
"endif

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
