"avoid source twice
if exists('b:did_vinux_ftplugin') 
    finish
endif
let b:did_vinux_ftplugin = 1
setlocal tabstop=4
setlocal softtabstop=4
setlocal shiftwidth=4
setlocal textwidth=79
setlocal expandtab
setlocal autoindent
setlocal fileformat=unix

nnoremap <buffer><silent> <Enter> :call te#complete#goto_def("")<cr>
nnoremap <buffer> <C-\>g :split<cr>:call te#complete#goto_def("")<cr>

"sudo pip3 install yapf
if te#env#Executable('yapf')
    nnoremap <buffer><leader>cf :0,$!yapf<CR>
    vnoremap <buffer><leader>cf :!yapf<CR>
elseif te#env#Executable('autopep8')
    nnoremap <buffer><leader>cf :%!autopep8 -<CR>
    vnoremap <buffer><leader>cf :!autopep8 -<CR>
else
    nnoremap <buffer><leader>cf :call te#utils#EchoWarning("Please install yapf or autopep8")<cr>
    vnoremap <buffer><leader>cf :call te#utils#EchoWarning("Please install yapf or autopep8")<cr>
endif
