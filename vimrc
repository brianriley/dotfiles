set nocompatible
filetype off

set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" let Vundle manage Vundle, required
Plugin 'gmarik/Vundle.vim'

Plugin 'ervandew/supertab'          " tab auto complete
Plugin 'jamessan/vim-gnupg'         " gpg in vim
Plugin 'janko-m/vim-test'           " test runner
Plugin 'junegunn/goyo.vim'          " distraction-free writing
Plugin 'mbbill/undotree'            " undo chain
Plugin 'NLKNguyen/papercolor-theme' " color scheme
Plugin 'Raimondi/delimitMate'       " auto complete quotes, brackets, etc.
Plugin 'reedes/vim-pencil'          " make vim a better writing tool
Plugin 'scrooloose/syntastic'       " auto syntax checking
Plugin 'sheerun/vim-polyglot'       " all the languages
Plugin 'tpope/vim-abolish.git'      " `crs` for snake case and `crc` for camel case!
Plugin 'tpope/vim-commentary'       " auto comment selected code
Plugin 'tpope/vim-endwise'          " add `end` to ruby and other code
Plugin 'tpope/vim-eunuch'           " shell commands: :Move, :Rename, :Mkdir, etc.
Plugin 'tpope/vim-fugitive'         " git integration
Plugin 'tpope/vim-surround'         " change surrounding quotes, brackets, etc.

call vundle#end()
filetype plugin indent on
syntax on
set omnifunc=syntaxcomplete#Complete

runtime! macros/matchit.vim

set laststatus=2

set encoding=utf-8
set fileencoding=utf-8

set autoindent
set backspace=2         " allow erasing previously entered characters
set clipboard=unnamed   " system clipboard
set cursorline          " highlight the screen line the cursor is on
set expandtab
set history=10000
set nohls
set noswapfile
set number
set ruler
set scrolloff=3
set softtabstop=2
set shell=zsh
set shiftwidth=2
set t_ti= t_te=
set tabstop=2
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
nmap <CR> :nohlsearch<CR>
autocmd BufReadPost quickfix nmap <buffer> <CR> <CR>
" make regexes Perl style
set magic
set ignorecase
set smartcase
" Automatically open, but do not go to (if there are errors) the quickfix /
" location list window, or close it when is has become empty.
"
" Note: Must allow nesting of autocmds to enable any customizations for
" quickfix buffers.
"
" Note: Normally, :cwindow jumps to the quickfix window if the command opens
" it (but not if it's already open). However, as part of the autocmd, this
" doesn't seem to happen.
autocmd QuickFixCmdPost [^l]* nested cwindow
autocmd QuickFixCmdPost    l* nested lwindow
" The Silver Searcher
if executable('ag')
  " Use ag over grep
  set grepprg=ag\ --vimgrep
endif
" bind K to grep word under cursor
nnoremap K :grep! "\b<C-R><C-W>\b"<CR>:cw<CR>
nnoremap <leader>f :grep<SPACE>
if executable('fzf')
  set rtp+=/usr/local/opt/fzf
  nnoremap <leader>e :FZF<cr>
endif
" search for the visual selection with //
vnoremap // y/<C-R>"<CR>"

""""""""""
" colors "
""""""""""
set t_Co=256
colorscheme PaperColor
if $SHELLBG == 'dark'
  set background=dark
else
  set background=light
endif

" Source the vimrc file after saving it
if has("autocmd")
  autocmd bufwritepost .vimrc,vimrc source $MYVIMRC
endif

augroup SetFiletypes
  autocmd!
  autocmd BufNewFile,BufReadPost *.markdown,*.md,*.mdown,*.mkd,*.mkdn set filetype=markdown
  autocmd BufNewFile,BufReadPost *.txt,README,INSTALL,NEWS,TODO set filetype=text
augroup END

augroup FiletypeOptions
  autocmd!
  autocmd FileType python,markdown set sw=4 sts=4 et
  autocmd FileType markdown set ai formatoptions=tcroqn2 comments=n:>
  autocmd FileType mail,markdown,text call pencil#init()
  autocmd Filetype gitcommit setlocal spell textwidth=72
  autocmd FileType vim setlocal keywordprg=:help
  autocmd FileType ruby setlocal keywordprg=ri
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
  let origin = substitute(substitute(system("git config --get remote.origin.url"), "\\.git", "", ""), "\n", "", "")
  let branch = substitute(system("git rev-parse --abbrev-ref HEAD"), "\n", "", "")
  let filepath = substitute(expand('%:p'), reporoot, "", "")
  let linenumber = line('.')
  let url = origin . "/blob/" . branch . filepath . "#L" . linenumber
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

map <leader>q :q<cr>
map <leader>Q :qa<cr>
map <leader>r :r<SPACE>
map <leader>v :v<SPACE>
map <leader>w :w<cr>
map <leader>W :wa<cr>
map <leader>x :x<cr>
map <leader><leader> :b#<cr>
map <leader>1 :!<SPACE>

" Insert blank lines w/o leaving normal mode
nmap <leader><CR> o<Esc>
nmap <leader><S-CR> O<Esc>

nmap <Up> <nop>
nmap <Down> <nop>
nmap <Left> <nop>
nmap <Right> <nop>

" Misspelled words
iab teh the

imap <C-c> <Esc>

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

""""""""""""
" Plugins
""""""""""""
" Goyo
" From
" https://github.com/junegunn/goyo.vim/wiki/Customization#ensure-q-to-quit-even-when-goyo-is-active
function! s:goyo_enter()
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
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 0
let g:syntastic_check_on_wq = 0
let g:syntastic_mode_map = { "mode": "passive" }
let g:syntastic_ruby_checkers = ['rubocop', 'mri']
let g:syntastic_python_checkers = ['pep8', 'pyflakes', 'python']

nmap <leader>ss :SyntasticCheck<cr>

" Undotree
if has("persistent_undo")
  set undodir='~/.undodir/'
  set undofile
endif

" vim-test
nmap <silent> <leader>t :TestNearest<CR>
nmap <silent> <leader>T :TestFile<CR>
let test#javascript#jasmine#file_pattern = '\-test\.js'
let test#javascript#jasmine#executable = 'npm test'

" vim-pencil
let g:pencil#wrapModeDefault = 'soft'

" supertab
let g:SuperTabDefaultCompletionType = "context"

autocmd FileType *
  \ if &omnifunc != '' |
  \   call SuperTabChain(&omnifunc, "<c-p>") |
  \   call SuperTabSetDefaultCompletionType("<c-x><c-u>") |
  \ endif

nmap fw :grep -r <cword> . <cr>
map <leader>cn :cnext<cr>
map <leader>cp :cprev<cr>
map <leader>co :copen<cr>
map <leader>cc :ccl<cr>

set tags=.git/tags;$HOME/tags
nmap <leader>ct :execute "!ctags -R ."<cr>
nmap gd <C-]>
nmap gb <C-t>

" vim-surround
nmap <leader>' ysiw'
nmap <leader>" ysiw"
nmap <leader>] ysiw[
nmap <leader>] ysiw]
nmap <leader>{ ysiw{
nmap <leader>} ysiw}
nmap <leader>( ysiw(
nmap <leader>) ysiw)
nmap <leader>` ysiw`

""""""""""""
" Status
""""""""""""
set statusline=\ %f\ %m%=%cC\ %y\  

" proper coloring in diff mode
hi User1 guifg=#eea040 guibg=#222222
hi User2 guifg=#dd3333 guibg=#222222
hi User3 guifg=#ff66ff guibg=#222222
hi User4 guifg=#a0ee40 guibg=#222222
hi User5 guifg=#eeee40 guibg=#222222
