syntax on
set number
colorscheme elflord
set hls  " highlight search

" Highlighting column 81
au BufRead,BufNewFile *.py    setlocal errorformat=\ \\*%t:\ \\*%l:\ \\*%m
au BufRead,BufNewFile *.py    setlocal shellpipe=2>/dev/null\ \|\ tee
autocmd BufReadPost * if line("'\"") && line("'\"") <= line("$") | exe "normal `\"" | endif
function! HighlightTooLongLines()
    highlight def link RightMargin Error
    if &textwidth != 0
	exec 'match RightMargin /\%<' . (&textwidth + 4) . 'v.\%>' . (&textwidth + 2) . 'v/'
    endif
endfunction

augroup filetypedetect
au BufNewFile,BufRead * call HighlightTooLongLines()
augroup END


" size of a hard tabstop
" set tabstop=4

" size of an "indent"
" set shiftwidth=4

" a combination of spaces and tabs are used to simulate tab stops at a width
" other than the (hard)tabstop
" set softtabstop=4
" autocmd FileType bzl,blazebuild AutoFormatBuffer buildifier
"
set tabstop=2 shiftwidth=2 expandtab
