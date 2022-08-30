""""""""""" Plugins """""""""""
call plug#begin('~/.vim/plugged')
    Plug 'gmarik/Vundle.vim'
    Plug 'itchyny/lightline.vim'
    Plug 'frazrepo/vim-rainbow'
    Plug 'kovetskiy/sxhkd-vim'
    Plug 'vim-python/python-syntax'
    Plug 'ap/vim-css-color'
    Plug 'junegunn/vim-emoji'
    Plug 'dracula/vim',{'as': 'dracula'}
call plug#end()
filetype plugin indent on


""""""""""" Settings """""""""""
syntax on
set incsearch
set smartcase
set ignorecase
set nobackup
set noswapfile
set nu
set clipboard=unnamedplus
set noshowmode
set mouse=a
set expandtab
set smarttab
set shiftwidth=4
set tabstop=4
colorscheme dracula


""""""""""" Status Bar """""""""""
let g:lightline = {
      \ 'colorscheme': 'darcula',
      \ }

set laststatus=2
