"
"   ________
"   | _____ \
"   | |  _/ /      Pim Nelissen
"   | | /__/       p1m@disroot.org
"   | |    	   https://pim.wtf/
"   \_|
"
" Neovim configuation file.

call plug#begin('~/.local/share/nvim/plugged')
Plug 'vimsence/vimsence'
Plug 'lervag/vimtex'
Plug 'python-mode/python-mode'
Plug 'rust-lang/rust.vim'
Plug 'Gavinok/vim-troff'
call plug#end()

:set number relativenumber

let g:tex_flavor='latex'
let g:vimtex_view_method='zathura'
let g:vimtex_quickfix_mode=0
let g:vimtex_view_general_viewer = 'zathura'

highlight LineNr ctermfg=8
