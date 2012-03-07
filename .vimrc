call pathogen#infect()

set nocompatible
set laststatus=2

set encoding=utf-8
set fileencoding=utf-8

set softtabstop=4
set shiftwidth=4
set tabstop=4
set autoindent
set expandtab
set ruler
set noswapfile
set nohls
set number

" split windows to the right or below the current window
set splitright splitbelow

let mapleader=","

" search
set incsearch
set hlsearch
" clear highlight on carriage return
nnoremap <CR> :nohlsearch<cr>

set ignorecase
set smartcase

syntax on
set t_Co=256
set background=light
colors sorcerer
if has("gui_running")
  set cursorline
  set invmmta
  set guioptions-=T
  set guifont=Monaco:h11
endif

set whichwrap+=<,>,[,]
set wrap linebreak nolist

augroup mkd
  autocmd BufRead *.mkd  set ai formatoptions=tcroqn2 comments=n:>
augroup END

" scrollbars
set guioptions-=L
set guioptions-=r

filetype on            " enables filetype detection
filetype plugin on     " enables filetype specific plugins
if has("autocmd")
  filetype plugin indent on
endif

" have pep8 ignore line length
let g:pep8_ignore="E501"

map <leader>o :CommandT<cr>
map <leader>t :wa\|:! nosetests<cr>

" move up/down within wrapped lines
map <up> gk
nmap k gk
map <Down> gj
nmap j gj

" move single lines up and down
nmap <S-k> ddkP
nmap <S-j> ddp
" move blocks up and down
vmap <S-k> xkP`[V`]
vmap <S-j> xp`[V`]

set wildignore+=*.pyc
set wildmenu

" remap C-W C-<key> to C-<key> for
" moving between splits
map <C-J> <C-W>j
map <C-K> <C-W>k
map <C-H> <C-W>h
map <C-L> <C-W>l

map <leader>w :w<cr>
map <leader>q :q<cr>
map <leader><leader> :b#<cr>

" Insert blank lines w/o leaving normal mode
nmap <Leader><CR> o<Esc>

" From https://github.com/garybernhardt/dotfiles/blob/master/.vimrc
function! InsertTabWrapper()
    let col = col('.') - 1
    if !col || getline('.')[col - 1] !~ '\k'
        return "\<tab>"
    else
        return "\<c-p>"
    endif
endfunction
inoremap <tab> <c-r>=InsertTabWrapper()<cr>
inoremap <s-tab> <c-n>

" shortcuts to wrap words in quotes and brackets
nmap <silent> <leader>' ciw'<C-r>"'<esc>
nmap <silent> <leader>" ciw"<C-r>""<esc>
nmap <silent> <leader>( ciw(<C-r>")<esc>
nmap <silent> <leader>[ ciw[<C-r>"]<esc>
nmap <silent> <leader>{ ciw{<C-r>"}<esc>
nmap <silent> <leader>< ciw<<C-r>"><esc>

nmap <Up> :echo "kだよ、k"<cr>
nmap <Down> :echo "jだよ、j"<cr>
nmap <Left> :echo "hだよ、h"<cr>
nmap <Right> :echo "lだよ、l"<cr>

map <leader>p :Dpaste<cr>

" Misspelled words
iab teh the
