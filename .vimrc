call pathogen#infect()

set nocompatible
set laststatus=2

set encoding=utf-8
set fileencoding=utf-8

set history=10000
set softtabstop=4
set shiftwidth=4
set tabstop=4
set autoindent
set expandtab
set ruler
set noswapfile
set nohls
set number
set scrolloff=3
set clipboard=unnamed
set t_ti= t_te=
set shell=bash

" split windows to the right or below the current window
set splitright splitbelow

let mapleader=","

""""""""""
" search "
""""""""""
set incsearch
set hlsearch
" clear highlight on carriage return
nnoremap <CR> :nohlsearch<cr>
" make regexes Perl style
set magic
set ignorecase
set smartcase

""""""""""
" colors "
""""""""""
set t_Co=256
colors ir_briley
set cursorline
hi cursorline ctermfg=NONE

set whichwrap+=<,>,h,l,[,]
set wrap linebreak nolist

augroup vimAutocmds
  autocmd!
  autocmd BufEnter * if &filetype == "" | setlocal ft=text | endif
  autocmd FileType text,gitcommit setlocal spell

  " Jump to last cursor position in file unless it's invalid or in an event handler
  autocmd BufReadPost *
    \ if line("'\"") > 0 && line("'\"") <= line("$") |
    \   exe "normal g`\"" |
    \ endif
  " Except for git commit messages
  autocmd BufReadPost COMMIT_EDITMSG
    \ exe "normal! gg"

  autocmd FileType ruby,haml,eruby,yaml set ai sw=2 sts=2 et
  autocmd FileType python,html,javascript,sass,cucumber set sw=4 sts=4 et

  autocmd BufRead *.mkd  set ai formatoptions=tcroqn2 comments=n:>
  autocmd BufRead *.markdown  set ai formatoptions=tcroqn2 comments=n:>
augroup END

syntax on
filetype plugin indent on

""""""""""""
" Command T
""""""""""""
map <leader>o :CommandT<cr>
map <leader>O :CommandT %:h<cr>

"""""""""
" Tests
"""""""""
function! RunDjangoTests()
    :! python manage.py test
endfunction

function! RunNoseTests()
    :! nosetests
endfunction

function! RunTests()
    :wa
    if filereadable("manage.py")
        call RunDjangoTests()
    else
        call RunNoseTests()
    endif
endfunction

map <leader>t :call RunTests()<cr>

""""""""""""
" Movements
""""""""""""
" move up/down within wrapped lines
map <up> gk
nmap k gk
map <Down> gj
nmap j gj

" move blocks up and down
vmap <S-k> xkP`[V`]
vmap <S-j> xp`[V`]

" remap C-W C-<key> to C-<key> for
" moving between splits
map <C-J> <C-W>j
map <C-K> <C-W>k
map <C-H> <C-W>h
map <C-L> <C-W>l

" auto-resize panes to 60% of window
let &winheight = &lines * 6 / 10
let &winwidth = &columns * 6 / 10

""""""""""""
" Search
""""""""""""
set wildignore+=*.pyc
set wildmenu

map <leader>w :w<cr>
map <leader>W :wqa<cr>
map <leader>q :q<cr>
map <leader>Q :q!<cr>
map <leader>v :v 
map <leader>e :e 
map <leader><leader> :b#<cr>

" Insert blank lines w/o leaving normal mode
nmap <leader><CR> o<Esc>
nmap <leader><S-CR> O<Esc>

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

nmap <Up> <nop>
nmap <Down> <nop>
nmap <Left> <nop>
nmap <Right> <nop>

" Misspelled words
iab teh the

imap <C-c> <Esc>
