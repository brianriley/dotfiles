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
colorscheme jellybeans
set cursorline

""""""""""
" status "
""""""""""
set statusline=%f\ (%{&ft})\ %m%=%lL,%cC\ %P

set whichwrap+=<,>,h,l,[,]
set wrap linebreak nolist

augroup spelling
    autocmd!
    autocmd BufEnter * if &filetype == "" | setlocal ft=text | endif
    autocmd FileType text,gitcommit setlocal spell
augroup END

augroup jump_to_last_position
    autocmd!
    " Jump to last cursor position in file unless it's invalid or in an event handler
    autocmd BufReadPost *
        \ if line("'\"") > 0 && line("'\"") <= line("$") |
        \   exe "normal g`\"" |
        \ endif
    " Except for git commit messages
    autocmd BufReadPost COMMIT_EDITMSG
        \ exe "normal! gg"
augroup END

augroup two_space_types
    autocmd!
    autocmd FileType ruby,haml,eruby,yaml set ai sw=2 sts=2 et
augroup END

augroup four_space_types
    autocmd!
    autocmd FileType python,html,javascript,sass,cucumber set sw=4 sts=4 et
augroup END

augroup ft_coffeescript
    autocmd!
    autocmd BufNewFile,BufRead *.coffee set filetype=coffee
augroup END

augroup ft_markdown
    autocmd!
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

function! RunSpec()
    :! rspec
endfunction

function! RunTests()
    :wa
    if &ft == "ruby"
        call RunSpec()
    elseif filereadable("manage.py")
        call RunDjangoTests()
    else
        call RunNoseTests()
    endif
endfunction

map <leader>t :call RunTests()<cr>

""""""""""""
" Open current file and line on GitHub
""""""""""""
function! OpenOnGitHub()
    let reporoot = substitute(system("git rev-parse --show-toplevel"), "\n", "", "")
    let origin = substitute(substitute(split(system("git config --get remote.origin.url"), ":")[1], ".git", "", ""), "\n", "", "")
    let branch = substitute(system("git rev-parse --abbrev-ref HEAD"), "\n", "", "")
    let filepath = substitute(expand('%:p'), reporoot, "", "")
    let linenumber = line('.')
    let url = "https://github.com/" . origin . "/blob/" . branch . filepath . "#L" . linenumber
    call system("open " . url)
endfunction

map <leader>g :call OpenOnGitHub()<cr>

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

" auto-resize panes to 60% of window...
let &winheight = &lines * 6 / 10
let &winwidth = &columns * 6 / 10
" ...and resize when the window has been resized
au VimResized * :wincmd =

""""""""""""
" Search
""""""""""""
set wildignore+=*.pyc
set wildmenu

map <leader>w :w<cr>
map <leader>W :wqa<cr>
map <leader>q :q<cr>
map <leader>Q :qa<cr>
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
nmap <silent> <leader>` ciw`<C-r>"`<esc>
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
