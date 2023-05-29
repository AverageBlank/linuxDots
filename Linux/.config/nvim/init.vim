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
    Plug 'preservim/tagbar'
    Plug 'tpope/vim-commentary'
    Plug 'davidhalter/jedi-vim'
    Plug 'ervandew/supertab'
    Plug 'tpope/vim-surround'
call plug#end()
filetype plugin indent on


""""""""""" Settings """""""""""
syntax on
set incsearch
set nohlsearch
set smartcase
set ignorecase
set nobackup
set noswapfile
set nu
set rnu
set clipboard=unnamedplus
set noshowmode
set mouse=a
set expandtab
set smarttab
set shiftwidth=4
set tabstop=4 softtabstop=4
set encoding=UTF-8


""""""""""" ColorScheme """""""""""
if has('termguicolors')
    " Turns on true terminal colors
    let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
    let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"

    " Turns on 24-bit RGB color support
    set termguicolors

    " Defines how many colors should be used. (maximum: 256, minimum: 0)
    set t_Co=256
endif

"" Setting Background
set background=dark
colorscheme onedark

"" Status Bar
let g:lightline = {
      \ 'colorscheme': 'onedark',
      \ }

set laststatus=2


""""""""""" Tab Guides """""""""""
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

"" Switching Between Lines ""
map <C-a> <ESC>^
inoremap <C-a> <ESC>I
map <C-e> <ESC>$
inoremap <C-e> <ESC>A
inoremap <C-BS> <C-W>
