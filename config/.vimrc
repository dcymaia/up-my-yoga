call plug#begin('~/.vim/plugged')
    Plug 'ctrlpvim/ctrlp.vim'
    Plug 'scrooloose/nerdtree'
    Plug 'scrooloose/nerdcommenter'
    Plug 'tpope/vim-fugitive'
    Plug 'tpope/vim-surround'
    Plug 'vim-airline/vim-airline'
    Plug 'vim-airline/vim-airline-themes'
    Plug 'dracula/vim', {'as': 'dracula'}
    Plug 'Yggdroot/indentLine'
    "Plug 'Valloric/YouCompleteMe'
    Plug 'vim-syntastic/syntastic'
    Plug 'michaeljsmith/vim-indent-object'
    Plug 'mattn/emmet-vim'
    Plug 'jdonaldson/vaxe'
    Plug 'lambdalisue/vim-django-support'
    "Plug 'posva/vim-vue'
    Plug 'Chiel92/vim-autoformat'
    Plug 'dart-lang/dart-vim-plugin'
    Plug 'thosakwe/vim-flutter'
call plug#end()

syntax on
color dracula

set noswapfile
set encoding=UTF-8
set fileencoding=utf-8
set expandtab
set softtabstop=4
set shiftwidth=4
"set autoindent
"set smartindent
set hlsearch
"set number relativenumber
set nu
set backspace=indent,eol,start
set nofoldenable
set clipboard=unnamedplus
set colorcolumn=100
set t_Co=256
set conceallevel=0
set completeopt-=preview

set foldmethod=indent
set foldnestmax=99


let g:ycm_auto_trigger = 0
let mapleader = ','
let g:airline_theme = 'jellybeans'

let NERDTreeShowHidden = 1
let NERDTreeIgnore = ['\.pyc$', '^__pycache__$', '^tags$']
let NERDTreeMapOpenInTab='<space>'
if argc() == 0
    autocmd VimEnter * NERDTree
    au VimEnter * if exists(':NERDTree') | wincmd l | endif
    au VimEnter * if exists(':NERDTree') | wincmd c | endif
endif

let g:syntastic_quiet_messages = {"!level": "errors"}


autocmd FileType html setlocal shiftwidth=2 softtabstop=2 expandtab
autocmd FileType htmldjango setlocal shiftwidth=2 softtabstop=2 expandtab
autocmd FileType css setlocal shiftwidth=2 softtabstop=2 expandtab
autocmd FileType scss setlocal shiftwidth=2 softtabstop=2 expandtab
autocmd FileType xml setlocal shiftwidth=2 softtabstop=2 expandtab
autocmd FileType yaml setlocal shiftwidth=2 softtabstop=2 expandtab
autocmd FileType haxe setlocal colorcolumn=120
autocmd FileType haxe setlocal colorcolumn=120

autocmd BufNewFile,BufRead *.sp    set syntax=cpp

"augroup numbertoggle
    "autocmd!
    "autocmd BufEnter,FocusGained,InsertLeave * set relativenumber
    "autocmd BufLeave,FocusLost,InsertEnter   * set norelativenumber
"augroup END


" search highlight
map ! :nohl<cr>
map # *``

map <f1> viw"_s
imap <f1> <esc>lviw"_s

" folding
"map <f2> Viizf
map <f2> za


" nerdtree
map <f3> :NERDTreeToggle<cr>

" create tags
map <f4> :!~/scripts/tags.py<cr><cr>

" save file
map <f5> :w<cr>
imap <f5> <esc>:w<cr>

map <f7> :Autoformat<cr>

map <f8> let @q="/^[^ }/\t].*{$<cr>kdk2kdK4"

" go to definition
"map <f9> <c-w><C-]><c-w>L
map <f9> *``<c-w>]<c-w>T<cr>

" find in file
nnoremap <f10> *``viw"wy:!PATH=/bin ~/scripts/find_in_file.sh % <c-r>w<cr><cr>

" find in project
nnoremap <s-f10> *``viw"wy:!PATH=/bin ~/scripts/find_in_project.sh <c-r>w<cr><cr>


map <f11> n<down><f2>
map <f12> @q


" scrolling
nmap \| 20k
nmap \ 20j
map <c-up> <c-y>
map <c-down> <c-e>


" tabs
map <c-s-left> gT
map <c-s-right> gt
"map <c-s-4> :tabmove -1
"map <c-s-6> :tabmove +1


" move line
"nnoremap <c-,> :m-2<cr>
"nnoremap <c-.> :m+1<cr>


" avoid cut
nnoremap C "_C
"nnoremap d "_d
nnoremap D "_dd
nnoremap s "_s
nnoremap x "_x

vnoremap s "_s

xnoremap p pgvy


" Move visual block
"vnoremap J :m '>+1<cr>gv=gv
"vnoremap K :m '<-2<cr>gv=gv

