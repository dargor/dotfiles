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
let g:lsp_diagnostics_virtual_text_prefix = "💥 "

let g:lsp_document_code_action_signs_enabled = 0
let g:lsp_document_highlight_delay = 200

let g:lsp_inlay_hints_delay = 200
let g:lsp_inlay_hints_enabled = 1

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

if executable('gopls')
    " https://github.com/golang/tools/blob/master/gopls/doc/vim.md#vimlsp
    autocmd User lsp_setup call lsp#register_server(#{
    \   name: 'Go Language Server',
    \   cmd: {server_info->['gopls', '-remote=auto']},
    \   allowlist: ['go', 'gomod', 'gohtmltmpl', 'gotexttmpl'],
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

if executable('protobuf-language-server')
    " https://github.com/lasorda/protobuf-language-server#installation
    autocmd User lsp_setup call lsp#register_server(#{
    \   name: 'Protobuf Language Server',
    \   cmd: {server_info->[&shell, &shellcmdflag, 'protobuf-language-server -stdio -logs ""']},
    \   allowlist: ['proto'],
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
    \         black: #{
    \           enabled: v:true,
    \         },
    \         flake8: #{
    \           enabled: v:true,
    \           extendIgnore: ['Q000'],
    \         },
    \         isort: #{
    \           enabled: v:true,
    \         },
    \         mccabe: #{
    \           enabled: v:false,
    \         },
    \         pylsp_mypy: #{
    \           enabled: v:true,
    \           follow-imports: 'normal',
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
    \       targetDir: v:true,
    \     },
    \     check: #{
    \       command: "clippy",
    \     },
    \     inlayHints: #{
    \       closingBraceHints: #{
    \         minLines: 0,
    \       },
    \       maxLength: v:null,
    \     },
    \   },
    \ })
endif

if executable('taplo')
    " https://taplo.tamasfe.dev/cli/usage/language-server.html
    autocmd User lsp_setup call lsp#register_server(#{
    \   name: 'TOML Language Server',
    \   cmd: {server_info->['taplo', 'lsp', 'stdio']},
    \   allowlist: ['toml'],
    \   workspace_config: {},
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

"if executable('vue-language-server')
"    " https://github.com/vuejs/language-tools#community-integration
"    autocmd User lsp_setup call lsp#register_server(#{
"    \   name: 'Vue Language Server',
"    \   cmd: {server_info->[&shell, &shellcmdflag, 'vue-language-server --stdio']},
"    \   allowlist: ['vue'],
"    \   initialization_options: #{
"    \     typescript: #{
"    \       tsdk: 'node_modules/typescript/lib',
"    \     },
"    \   },
"    \ })
"endif

"if executable('yaml-language-server')
"    " https://github.com/redhat-developer/yaml-language-server#connecting-to-the-language-server-via-stdio
"    autocmd User lsp_setup call lsp#register_server(#{
"    \   name: 'YAML Language Server',
"    \   cmd: {server_info->[&shell, &shellcmdflag, 'yaml-language-server --stdio']},
"    \   allowlist: ['yaml'],
"    \ })
"endif

function! s:on_lsp_buffer_enabled() abort
    setlocal nowrap
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
    nmap <buffer> tt <plug>(lsp-definition)
    nnoremap <buffer> <expr><c-k> lsp#scroll(-3)
    nnoremap <buffer> <expr><c-j> lsp#scroll(+3)
    autocmd! BufWritePre *.py,*.rs,*.go call execute('LspDocumentFormatSync')
endfunction

augroup lsp_install
    autocmd!
    autocmd User lsp_buffer_enabled call s:on_lsp_buffer_enabled()
augroup END
