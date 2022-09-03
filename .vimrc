""""""""""" Plugins """""""""""
call plug#begin('~/.vim/plugged')
    Plug 'gmarik/Vundle.vim'
    Plug 'itchyny/lightline.vim'
    Plug 'frazrepo/vim-rainbow'
    Plug 'kovetskiy/sxhkd-vim'
    Plug 'vim-python/python-syntax'
    Plug 'ap/vim-css-color'
    Plug 'junegunn/vim-emoji'
    Plug 'preservim/nerdtree'
    Plug 'joshdick/onedark.vim'
    Plug 'ryanoasis/vim-devicons'
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
set tabstop=4 softtabstop=4
set encoding=UTF-8
colorscheme onedark


""""""""""" Status Bar """""""""""
let g:lightline = {
      \ 'colorscheme': 'onedark',
      \ }

set laststatus=2


""""""""""" Tab Guides"""""""""""
set list listchars=tab:❘-,trail:·,extends:»,precedes:«,nbsp:×
autocmd! bufreadpost * set noexpandtab | retab! 4
autocmd! bufwritepre * set expandtab | retab! 4
autocmd! bufwritepost * set noexpandtab | retab! 4
""""""""""" Keybindings """""""""""
"" NerdTree ""
" Open NerdTree with ctrl+p
nnoremap <leader>n :NERDTreeFocus<CR>
nnoremap <C-p> :NERDTreeToggle<CR>
" AutoStart NerdTree
autocmd VimEnter * NERDTree | wincmd p

"" Navigating Splits ""
nnoremap <silent> <c-k> :wincmd k<CR>
nnoremap <silent> <c-j> :wincmd j<CR>
nnoremap <silent> <c-h> :wincmd h<CR>
nnoremap <silent> <c-l> :wincmd l<CR>

"" Making Programming Easier ""
inoremap ( ()<Left>
inoremap [ []<Left>
inoremap { {}<Left>
inoremap ' ''<left>
inoremap " ""<left>
