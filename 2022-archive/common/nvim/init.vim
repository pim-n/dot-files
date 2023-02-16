"   ________
"   | _____ \
"   | |  _/ /      Pim Nelissen
"   | | /__/       https://pim.wtf/
"   | |
"   \_|

" Neovim configuration file.

" load all plugins.
call plug#begin('~/.local/share/nvim/plugged')
Plug 'vimsence/vimsence'
Plug 'lervag/vimtex'
Plug 'python-mode/python-mode'
Plug 'rust-lang/rust.vim'
Plug 'Gavinok/vim-troff'
Plug 'vim-airline/vim-airline'
Plug 'Yggdroot/indentLine'
Plug 'vim-airline/vim-airline-themes'
call plug#end()

" configurations.
set number relativenumber
set tabstop=8 softtabstop=0 expandtab shiftwidth=4 smarttab
autocmd BufRead *.md set spell spelllang=en_uk
highlight LineNr ctermfg=8

" airline configuration.
let g:airline_theme='minimalist'
let g:airline_powerline_fonts=1
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#wordcount#enabled=1

" vimtex configuration.
let g:tex_flavor='latex'
let g:vimtex_view_method='zathura'
let g:vimtex_quickfix_mode=0
let g:vimtex_view_general_viewer='zathura'

" ignore some dumb PEP8 warnings.
let g:pymode_lint_ignore="E501,W"
let g:pymode_lint_ignore="E302,W"

" Set color of PEP8 line end column to grey.
autocmd BufRead *.py hi ColorColumn ctermbg=8

" other plugins configuration
let g:indentLine_leadingSpaceEnabled=1
let g:indentLine_leadingSpaceChar = '⬞'
let g:indentLine_fileTypeExclude = ['tex', 'markdown']

" Custom commands
" Uses F4 to find and replace every instance of the word under the cursor.
nnoremap <F4> :%s/<c-r><c-w>/<c-r><c-w>/gc<c-f>$F/i
