if exists(':LspDocumentFormatSync')
    autocmd! BufWritePre <buffer> call execute('LspDocumentFormatSync')
endif
