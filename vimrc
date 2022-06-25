call plug#begin('~/.vim/bundle')
Plug 'airblade/vim-gitgutter'                                " show git diff in gutter
Plug 'bogado/file-line'                                      " open files by line number: vim file.txt:123
Plug 'chriskempson/base16-vim'                               " base16 for colors
Plug 'haya14busa/is.vim'                                     " search improvements
Plug 'junegunn/fzf.vim'                                      " all my fuzzy finding needs
Plug 'machakann/vim-highlightedyank'                         " briefly highlight yanked text
Plug 'neoclide/coc.nvim', {'branch': 'release'}              " code completion, type and linter errors
Plug 'sheerun/vim-polyglot'                                  " all the languages
Plug 'tpope/vim-commentary'                                  " auto comment selected code
Plug 'tpope/vim-endwise'                                     " add `end` to ruby and other code
Plug 'tpope/vim-fugitive'                                    " git integration
Plug 'tpope/vim-surround'                                    " change surrounding quotes, brackets, etc.
Plug 'tpope/vim-vinegar'                                     " netrw improvements
Plug 'vim-test/vim-test'                                     " test runner
Plug 'vimwiki/vimwiki'                                       " for personal and work wikis
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
" set cursorline               " highlight the screen line the cursor is on
set expandtab
set hidden                   " allow unsaved buffers and remember undos
set history=10000
set mouse=a                  " turn on mouse for the optional interaction
set number
set ttymouse=sgr
set nohls
set noswapfile
set re=0                     " use new regex syntax highlighter
set scrolloff=3
set signcolumn=number        " merge sign column and number column
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
syntax on

" Don't ring the bell
set visualbell
set t_vb=

set mouse=a
set ttymouse=sgr
set balloondelay=250
set ballooneval
set balloonevalterm

" split windows to the right or below the current window
set splitright splitbelow

" help some language servers with backup issues
set nobackup
set nowritebackup

set cmdheight=2
set shortmess+=c

let mapleader=" "

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
  nnoremap <leader>* :Ag <C-R><C-W><cr>

  " search for filename
  nnoremap <leader>e :Files<cr>

  " search for buffer name
  nnoremap <leader>b :Buffers<cr>

  " search for text in open buffers
  nnoremap <leader>/ :Lines<cr>
endif

" search for the visual selection with //
vnoremap // y/<C-R>"<CR>"

" Histogram-based diffs
" https://www.reddit.com/r/vim/comments/cn20tv/tip_histogrambased_diffs_using_modern_vim/
if has("patch-8.1.0360")
  set diffopt=filler,internal,algorithm:histogram,indent-heuristic
endif

""""""""""
" colors "
""""""""""
augroup HighlightTrailingWhitespace
  autocmd!
  autocmd ColorScheme * highlight TrailingWhitespace ctermbg=8
  autocmd BufEnter * match TrailingWhitespace /\s\+$/
augroup END

set t_Co=256
colorscheme dim
set background=dark

augroup SetFiletypes
  autocmd!
  autocmd BufNewFile,BufReadPost *.markdown,*.md,*.mdown,*.mkd,*.mkdn set filetype=markdown
  autocmd BufNewFile,BufReadPost *.txt,README,INSTALL,NEWS,TODO set filetype=text
augroup END

augroup FiletypeOptions
  autocmd!
  autocmd FileType python,markdown set sw=4 sts=4 et
  autocmd FileType markdown set ai formatoptions=tcroqn2 comments=n:>
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
" function! OpenOnGitHub() abort
"   let reporoot = substitute(system("git rev-parse --show-toplevel"), "\n", "", "")
"   let origin = substitute(substitute(system("git config --get remote.origin.url"), "\\.git", "", ""), "\n", "", "")
"   let branch = substitute(system("git rev-parse --abbrev-ref HEAD"), "\n", "", "")
"   let filepath = substitute(expand('%:p'), reporoot, "", "")
"   let linenumber = line('.')
"   let url = origin . "/blob/" . branch . filepath . "#L" . linenumber
"   call system("open " . url)
" endfunction

" map <leader>g :call OpenOnGitHub()<cr>

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

nmap <leader>o :only<cr>
nmap <leader>, :e $MYVIMRC<cr>

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
function! ProdFileName(filename) abort
  let prod_file = substitute(a:filename, '_spec', '', '')
  return substitute(prod_file, 'spec/', '', '')
endfunction

function! SpecFileName(filename) abort
  let _spec_file = substitute(a:filename, '.rb', '_spec.rb', '')
  let spec_file = substitute(_spec_file, 'app/', '', '')
  return 'spec/' . spec_file
endfunction

function! ExpandPath(filename) abort
  let is_rails = isdirectory('app')
  if is_rails
    return 'app/' . a:filename
  else
    return a:filename
  endif
endfunction

function! GetOtherFile(filename) abort
  let is_spec = match(a:filename, '_spec.rb') != -1
  if is_spec
    return ExpandPath(ProdFileName(a:filename))
  else
    return SpecFileName(a:filename)
  endif
endfunction

function! MoveBetweenProdAndSpec() abort
  exec ':edit ' . GetOtherFile(expand("%"))
endfunction

map <leader>. :call MoveBetweenProdAndSpec()<cr>

""""""""""""
" Plugins
""""""""""""
" vim-test
nmap <silent> <leader>t :TestNearest<CR>
nmap <silent> <leader>T :TestFile<CR>
let test#javascript#jasmine#file_pattern = '\-test\.js'
let test#javascript#jasmine#executable = 'npm test'
let test#javascript#mocha#executable = './bin/mocha'

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

" gitgutter
nmap <leader>d :GitGutterToggle<cr>

" vimwiki
let g:vimwiki_list = [{'path': '~/Documents/vimwiki', 'syntax': 'markdown', 'ext': 'md'}]
let g:vimwiki_map_prefix = '<Leader>k'

" coc.vim
inoremap <expr> <Tab>   pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"

highlight CocHighlightText cterm=bold
autocmd CursorHold * silent call CocActionAsync('highlight')

nmap <buffer> <leader>ld <plug>(coc-definition)
nmap <buffer> <leader>lt <plug>(coc-type-definition)
nmap <buffer> <leader>li <plug>(coc-implementation)
nmap <buffer> <leader>lr <plug>(coc-references)
nmap <buffer> <leader>ln <plug>(coc-rename)
nmap <buffer> <leader>lf <plug>(coc-fix-current)
nmap <buffer> <leader>l/ <plug>(coc-diagnostics-next)
nmap <buffer> <leader>l? <plug>(coc-diagnostics-prev)

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
" snippet hack
""""""""""""
augroup Snippets
  autocmd!
  autocmd filetype html iab html <!DOCTYPE html><CR><html><CR><head><CR><meta charset="UTF-8"><CR><meta name="viewport" content="width=device-width,initial-scale=1"><CR><title>TITLE</title><CR></head><CR><body><CR></body><CR></html>
augroup END
