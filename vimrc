set nocompatible

call plug#begin('~/.vim/bundle')
Plug 'airblade/vim-gitgutter'                           " show git diff in gutter
Plug 'bogado/file-line'                                 " open files by line number: vim file.txt:123
Plug 'chriskempson/base16-vim'                          " base16 for colors
Plug 'ervandew/supertab'                                " tab auto complete
Plug 'haya14busa/is.vim'                                " search improvements
Plug 'jamessan/vim-gnupg'                               " gpg in vim
Plug 'janko-m/vim-test'                                 " test runner
Plug 'junegunn/fzf.vim'                                 " all my fuzzy finding needs
Plug 'junegunn/goyo.vim', { 'for': 'markdown' }         " distraction-free writing
Plug 'machakann/vim-highlightedyank'                    " briefly highlight yanked text
Plug 'mbbill/undotree', { 'on': 'UndotreeToggle' }      " undo chain
Plug 'Raimondi/delimitMate'                             " auto complete quotes, brackets, etc.
Plug 'reedes/vim-pencil'                                " make vim a better writing tool
Plug 'sheerun/vim-polyglot'                             " all the languages
Plug 'Shougo/unite.vim'                                 " required for vimfiler (must come before)
Plug 'Shougo/vimfiler.vim', { 'on': 'VimFilerExplorer'} " lightweight file explorer
Plug 'tpope/vim-commentary'                             " auto comment selected code
Plug 'tpope/vim-endwise'                                " add `end` to ruby and other code
Plug 'tpope/vim-eunuch'                                 " shell commands: :Move, :Rename, :Mkdir, etc.
Plug 'tpope/vim-fireplace', { 'for': 'clojure' }        " Clojure repl support
Plug 'tpope/vim-fugitive'                               " git integration
Plug 'tpope/vim-surround'                               " change surrounding quotes, brackets, etc.
Plug 'vimwiki/vimwiki'                                  " for personal and work wikis
Plug 'w0rp/ale'                                         " Asynchronous linter
call plug#end()

set omnifunc=syntaxcomplete#Complete

" jump between matching code constructs with %
runtime macros/matchit.vim

set encoding=utf-8
set fileencoding=utf-8

set autoindent
set autoread                 " update buffer when change detected outside of vim
set backspace=2              " allow erasing previously entered characters
set clipboard=unnamed        " system clipboard
set cursorline               " highlight the screen line the cursor is on
set expandtab
set hidden                   " allow unsaved buffers and remember undos
set history=10000
set mouse=a                  " turn on mouse for the optional interaction
set nohls
set noswapfile
set re=1                     " Ruby syntax highlighting is very slow with the new regex engine; use the old one
set scrolloff=3
set softtabstop=2
set shell=zsh
set shiftwidth=2
set t_ti= t_te=
set tabstop=2
set updatetime=250           " speeds up the update from 4 s to 250 ms
set whichwrap+=<,>,h,l,[,]
set wildignore+=*.pyc
set wildmenu
set wrap linebreak nolist

" Don't ring the bell
set visualbell
set t_vb=

" split windows to the right or below the current window
set splitright splitbelow

let mapleader=","

""""""""""
" folds  "
""""""""""
" toggle individual folds
nnoremap <Space> za

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

if executable('fzf')
  set rtp+=/usr/local/opt/fzf

  " search for text within the project
  nnoremap <leader>f :Ag<cr>

  " search for word under cursor
  nnoremap F :Ag <C-R><C-W><cr>

  " search for filename
  nnoremap <leader>e :Files<cr>

  " search for buffer name
  nnoremap <leader>b :Buffers<cr>

  " search for text in open buffers
  nnoremap <leader>/ :Lines<cr>
endif

" search for the visual selection with //
vnoremap // y/<C-R>"<CR>"

""""""""""
" colors "
""""""""""
set t_Co=256
if filereadable(expand("~/.vimrc_background"))
  let base16colorspace=256
  source ~/.vimrc_background
endif

" proper coloring in diff mode
hi User1 guifg=#eea040 guibg=#222222
hi User2 guifg=#dd3333 guibg=#222222
hi User3 guifg=#ff66ff guibg=#222222
hi User4 guifg=#a0ee40 guibg=#222222
hi User5 guifg=#eeee40 guibg=#222222

" Hightlight trailing whitespace
highlight TrailingWhitespace ctermbg=240 guibg=red
match TrailingWhitespace /\s\+$/

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

" Undotree
if has("persistent_undo")
  set undodir='~/.undodir/'
  set undofile
endif
nnoremap U :UndotreeToggle<cr>

" vim-test
nmap <silent> <leader>t :TestNearest<CR>
nmap <silent> <leader>T :TestFile<CR>
let test#javascript#jasmine#file_pattern = '\-test\.js'
let test#javascript#jasmine#executable = 'npm test'

" vim-pencil
let g:pencil#wrapModeDefault = 'soft'

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

" vimfiler
let g:vimfiler_as_default_explorer = 1
nmap <leader><space> :VimFilerExplorer<cr>

" gitgutter
nmap <leader>d :GitGutterToggle<cr>

" vimwiki
let g:vimwiki_list = [{'path': '~/Dropbox/vimwiki'}]
let g:vimwiki_map_prefix = '<Leader>k'

""""""""""""
" Status
""""""""""""
hi StatusLine ctermbg=0
hi StatusLineNC ctermbg=0
set laststatus=2                 " always show the status line
set statusline=%=                " switch to the right side
set statusline+=%m               " is the file modified?
set statusline+=\ %f             " relative path to file
set statusline+=\ \|\ %2lL:%2cC  " column number followed by a 'C'
set statusline+=\ \|\ %3p%%      " percent through file
set statusline+=\ %y             " filetype
set statusline+=\                " trailing space

""""""""""""
" ctags
""""""""""""
set tags=.git/tags;$HOME/tags
nmap <leader>ct :execute "!ctags -R ."<cr>
nmap gd <C-]>
nmap gb <C-t>
