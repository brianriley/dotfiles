set nocompatible
filetype off

set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" let Vundle manage Vundle, required
Plugin 'gmarik/Vundle.vim'

Plugin 'bling/vim-airline'
Plugin 'edkolev/tmuxline.vim'
Plugin 'elixir-lang/vim-elixir'
Plugin 'junegunn/goyo.vim'
Plugin 'mbbill/undotree'
Plugin 'michaelavila/selecta.vim'
Plugin 'Raimondi/delimitMate'
Plugin 'reedes/vim-colors-pencil'
Plugin 'reedes/vim-pencil'
Plugin 'scrooloose/syntastic'
Plugin 'tpope/vim-commentary'
Plugin 'tpope/vim-endwise'
Plugin 'tpope/vim-fugitive'
Plugin 'tpope/vim-surround'

call vundle#end()
filetype plugin indent on
syntax on

runtime! macros/matchit.vim

set laststatus=2

set encoding=utf-8
set fileencoding=utf-8

set history=10000
set backspace=2 " allow erasing previously entered characters
set softtabstop=2
set shiftwidth=2
set tabstop=2
set autoindent
set expandtab
set ruler
set noswapfile
set nohls
set scrolloff=3
set clipboard=unnamed
set t_ti= t_te=
set shell=bash
set number
set whichwrap+=<,>,h,l,[,]
set wrap linebreak nolist

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
set background=light
colorscheme pencil
set cursorline

augroup SetFiletypes
  autocmd!
  autocmd BufNewFile,BufReadPost *.markdown,*.md,*.mdown,*.mkd,*.mkdn set filetype=markdown
  autocmd BufNewFile,BufReadPost *.txt,README,INSTALL,NEWS,TODO set filetype=text
augroup END

augroup FiletypeOptions
  autocmd!
  autocmd FileType python,markdown set sw=4 sts=4 et
  autocmd FileType markdown set ai formatoptions=tcroqn2 comments=n:>
  autocmd FileType gitcommit,mail,markdown,text call pencil#init()
  autocmd FileType markdown Goyo 80
  autocmd FileType vim setlocal keywordprg=:help
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
map <leader>r :r 
map <leader>x :x<cr>
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

nmap <Up> <nop>
nmap <Down> <nop>
nmap <Left> <nop>
nmap <Right> <nop>

" Misspelled words
iab teh the

imap <C-c> <Esc>

"""""""""
" Tests
"""""""""
function! RunTests_ruby(filename, line)
  let is_spec = match(a:filename, '_spec.rb') != -1
  if is_spec
    let command = ':! bundle exec rspec ' . a:filename . ':' . a:line
  else
    if !exists('g:test_command')
      let command = ':! bundle exec rspec spec/'
    else
      let command = g:test_command
    endif
  endif
  let g:test_command = command
  exec command
endfunction

function! RunTests_cucumber(filename, line)
  exec ':! bundle exec cucumber ' . a:filename . ':' . a:line
endfunction

function! RunTests_python(filename, line)
  let is_test_file = match(a:filename, '/test') != -1
  if is_test_file
    exec ':! py.test ' . a:filename
  else
    exec ':! py.test'
  end
endfunction

function! RunTests_elixir(filename, line)
  exec ':! mix test ' . a:filename . ':' . a:line
endfunction

function! RunTests()
  :wa
  let filename = expand("%")
  let line = line(".")
  let test_runner = ':call RunTests_' . &ft . '("' . filename . '",' . line . ')'
  exec test_runner
endfunction

map <leader>t :call RunTests()<cr>

""""""""""""
" Move between production code and specs
""""""""""""
function! ProdFileName(filename)
  let prod_file = substitute(a:filename, '_spec', '', '')
  return substitute(prod_file, 'spec/', '', '')
endfunction

function! SpecFileName(filename)
  let _spec_file = substitute(a:filename, '.rb', '_spec.rb', '')
  let spec_file = substitute(_spec_file, 'app/', '', '')
  return 'spec/' . spec_file
endfunction

function! ExpandPath(filename)
  let is_rails = isdirectory('app')
  if is_rails
    return 'app/' . a:filename
  else
    return a:filename
  endif
endfunction

function! GetOtherFile(filename)
  let is_spec = match(a:filename, '_spec.rb') != -1
  if is_spec
    return ExpandPath(ProdFileName(a:filename))
  else
    return SpecFileName(a:filename)
  endif
endfunction

function! MoveBetweenProdAndSpec()
  exec ':edit ' . GetOtherFile(expand("%"))
endfunction

map <leader>. :call MoveBetweenProdAndSpec()<cr>

" Find all files in all non-dot directories starting in the working directory.
" Fuzzy select one of those. Open the selected file with :e.
nnoremap <leader>e :call SelectaFile()<cr>

" Find all buffers that have been opened.
" Fuzzy select one of those. Open the selected file with :e.
nnoremap <leader>b :call SelectaBuffer()<cr>

""""""""""""
" Plugins
""""""""""""
" Airline
let g:airline_powerline_fonts = 1
let g:airline_theme = "pencil"
" Tmuxline
let g:tmuxline_preset = {
      \'a'    : '#S',
      \'b'    : '#W',
      \'win'  : '#I #W',
      \'cwin' : '#I #W',
      \'z'    : '%a %b %d %R'}
let g:tmuxline_powerline_separators = 0


" Goyo
" From
" https://github.com/junegunn/goyo.vim/wiki/Customization#ensure-q-to-quit-even-when-goyo-is-active
function! s:goyo_enter()
  silent !tmux set status off
  set noshowmode
  set noshowcmd
  set scrolloff=999
  let b:quitting = 0
  let b:quitting_bang = 0
  autocmd QuitPre <buffer> let b:quitting = 1
  cabbrev <buffer> q! let b:quitting_bang = 1 <bar> q!
endfunction

function! s:goyo_leave()
  silent !tmux set status on
  set showmode
  set showcmd
  set scrolloff=3
  " Quit Vim if this is the only remaining buffer
  if b:quitting && len(filter(range(1, bufnr('$')), 'buflisted(v:val)')) == 1
    if b:quitting_bang
      qa!
    else
      qa
    endif
  endif
endfunction

autocmd User GoyoEnter call <SID>goyo_enter()
autocmd User GoyoLeave call <SID>goyo_leave()

" Syntastic
let g:syntastic_ruby_checkers = ['rubocop', 'mri']
let g:syntastic_python_checkers = ['pep8', 'pyflakes', 'python']

" Undotree
if has("persistent_undo")
  set undodir='~/.undodir/'
  set undofile
endif