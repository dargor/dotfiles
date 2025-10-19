augroup filetypedetect

    autocmd BufNewFile,BufRead *.hy,*.lfe setlocal filetype=lisp
    autocmd BufNewFile,BufRead *.pp setlocal filetype=ruby
    autocmd BufNewFile,BufRead *.{tf,tfvars} setlocal filetype=terraform syntax=hcl
    autocmd BufNewFile,BufRead *.{avsc,tfstate} setlocal filetype=json
    autocmd BufNewFile,BufRead Jenkinsfile setlocal filetype=groovy
    autocmd BufNewFile,BufRead Dockerfile.* setlocal filetype=dockerfile
    autocmd BufNewFile,BufRead master,roster,*.sls setlocal filetype=yaml
    autocmd BufNewFile,BufRead *.{cfg,cnf,coveragerc,sentryclirc,service,terraformrc,tigrc,timer},cqlshrc,{krb5,pip,spark-defaults,supervisord}.conf,.{scalafmt,scalafix}.conf,.bandit,.iredisrc setlocal filetype=dosini
    autocmd BufNewFile,BufRead *{requirements,constraints}*.txt setlocal filetype=conf
    autocmd BufNewFile,BufRead .{continue,docker,helm,rg}ignore setlocal filetype=gitignore
    autocmd BufNewFile,BufRead .gitconfig.* setlocal filetype=gitconfig
    autocmd BufNewFile,BufRead .{,*}rules setlocal filetype=markdown
    autocmd BufNewFile,BufRead .env{,.*} setlocal filetype=dosini
    autocmd BufNewFile,BufRead *.cql setlocal filetype=sql
    autocmd BufNewFile,BufRead *.bats setlocal filetype=sh
    autocmd BufNewFile,BufRead *.tcss setlocal filetype=css

    " pyx (implementation) and pxd (definition) are handled, but pxi (include) are not
    autocmd BufNewFile,BufRead *.pxi setlocal filetype=pyrex

    function! HelmSyntax()
        setlocal filetype=yaml
        unlet b:current_syntax
        syntax include @GO syntax/go.vim
        let b:current_syntax = 'yaml'
        syntax region goTxt matchgroup=goTpl start=/{{\(-\)\?/ end=/\(-\)\?}}/ contains=@GO containedin=ALLBUT,goTxt
        highlight link goTpl PreProc
    endfunction

    autocmd BufNewFile,BufRead */templates/*.yaml,*/templates/*.tpl call HelmSyntax()
    autocmd BufNewFile,BufRead */.ssh/config.* setlocal filetype=sshconfig

augroup END
