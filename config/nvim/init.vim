call plug#begin()
" fuzzy finding
Plug 'junegunn/fzf.vim'
" netrw improvements
Plug 'tpope/vim-vinegar'
" test runner
Plug 'vim-test/vim-test'
" git integration for buffers
Plug 'lewis6991/gitsigns.nvim'
" line commenting
Plug 'echasnovski/mini.comment'
" surrounds
Plug 'echasnovski/mini.surround'

" syntax parsing
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}

" LSP Support
Plug 'neovim/nvim-lspconfig'
Plug 'williamboman/mason.nvim'
Plug 'williamboman/mason-lspconfig.nvim'

" Autocompletion
Plug 'hrsh7th/nvim-cmp'
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-path'
Plug 'saadparwaiz1/cmp_luasnip'
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-nvim-lua'

"  Snippets
Plug 'L3MON4D3/LuaSnip'
Plug 'rafamadriz/friendly-snippets'

Plug 'VonHeikemen/lsp-zero.nvim'
call plug#end()

let mapleader=" "

set clipboard=unnamed        " system clipboard
set expandtab                " convert tabs to spaces
set fileencoding=utf-8
set ignorecase               " ignore case in search patterns
set nowritebackup
set noswapfile
set number                   " show line numbers
set scrolloff=3              " lines to keep at top and bottom
set shiftwidth=2             " number of space for each indent
set signcolumn=auto:4
set sidescrolloff=3          " lines to keep at left and right
set smartcase
set smartindent
set splitbelow               " split windows below current
set splitright               " split windows to the right
set t_Ce="\\e[24m"
set t_Cs="\\e[6m"
set t_te=
set tabstop=2
set updatetime=250           " speeds up the update for faster completion
set wrap

colorscheme dim
highlight SignColumn ctermbg=black

map <leader>q :q<cr>
map <leader>Q :qa<cr>
map <leader>r :r<SPACE>
map <leader>v :v<SPACE>
map <leader>w :w<cr>
map <leader>W :wa<cr>
map <leader>x :x<cr>
map <leader><leader> :b#<cr>
map <leader>1 :!<SPACE>
nmap <leader>, :e $MYVIMRC<cr>

" Insert blank lines w/o leaving normal mode
nmap <leader><CR> o<Esc>
nmap <leader><S-CR> O<Esc>

" remap C-W C-<key> to C-<key> for
" moving between splits
map <C-J> <C-W>j
map <C-K> <C-W>k
map <C-H> <C-W>h
map <C-L> <C-W>l

" vim-test
nmap <silent> <leader>t :TestNearest<CR>
nmap <silent> <leader>T :TestFile<CR>
let test#javascript#jasmine#file_pattern = '\-test\.js'
let test#javascript#jasmine#executable = 'npm test'
let test#javascript#mocha#executable = './bin/mocha'

" clear highlight on carriage return
nmap <CR> :nohlsearch<CR>

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

if executable('fzf')
  set rtp+=/opt/homebrew/Cellar/fzf/0.35.1/
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

lua <<EOF
require("nvim-treesitter.configs").setup({
  auto_install = true,
  highlight = {
    enable = true,
  },
})

local lsp = require('lsp-zero')
lsp.preset('recommended')

local cmp = require'cmp'
local cmp_mapping = lsp.defaults.cmp_mappings()
cmp_mapping['<Tab>'] = cmp.mapping.confirm({ select = true })
lsp.setup_nvim_cmp({
  mapping = cmp_mapping
})

local map = function(m, lhs, rhs)
  local opts = {remap = false, silent = true, buffer = bufnr}
  vim.keymap.set(m, lhs, rhs, opts)
end
-- LSP actions
map('n', '<leader>li', '<cmd>lua vim.lsp.buf.hover()<cr>')
map('n', '<leader>ld', '<cmd>lua vim.lsp.buf.definition()<cr>')
map('n', '<leader>lt', '<cmd>lua vim.lsp.buf.type_definition()<cr>')
map('n', '<leader>li', '<cmd>lua vim.lsp.buf.implementation()<cr>')
map('n', '<leader>lr', '<cmd>lua vim.lsp.buf.references()<cr>')
map('n', '<leader>ln', '<cmd>lua vim.lsp.buf.rename()<cr>')
map('n', '<leader>lf', '<cmd>lua vim.lsp.buf.code_action()<cr>')
map('n', '<leader>le', '<cmd>lua vim.diagnostic.open_float()<cr>')

-- Gitsigns
local gs = require('gitsigns')
gs.setup()
vim.api.nvim_set_hl(0, 'GitsignsAdd', { ctermfg = 'green', bg = 'black' })
vim.api.nvim_set_hl(0, 'GitsignsChange', { ctermfg = 'yellow', bg = 'black' })
vim.api.nvim_set_hl(0, 'GitsignsDelete', { ctermfg = 'red', bg = 'black' })
map('n', '<leader>gb', gs.blame_line)

lsp.setup()
EOF
