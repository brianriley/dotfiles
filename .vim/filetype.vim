" Special file type settings

if exists("did\_load\_filetypes")
 finish
endif

augroup filetypez
    au BufRead,BufNewFile *.mkd set filetype=mkd
    au BufRead,BufNewFile *.markdown set filetype=mkd
    au BufRead,BufNewFile *.clj set filetype=lisp
augroup END

