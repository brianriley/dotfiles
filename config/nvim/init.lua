local vim = vim

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

vim.g.mapleader = ' '

require('lazy').setup('plugins')

local builtin = require('telescope.builtin')

vim.o.clipboard = 'unnamedplus'    -- system clipboard
vim.o.cursorline = true
vim.o.expandtab = true         -- convert tabs to spaces
vim.o.ignorecase = true        -- ignore case in search patterns
vim.o.number = true            -- show line numbers
vim.o.scrolloff = 3            -- lines to keep at top and bottom
vim.o.shiftwidth = 2           -- number of space for each indent
vim.o.signcolumn = 'yes'       -- add LSP/git signs to the left
vim.o.sidescrolloff = 3        -- lines to keep at left and right
vim.o.smartcase = true
vim.o.smartindent = true
vim.o.splitbelow = true        -- split windows below current
vim.o.splitright = true        -- split windows to the right
vim.o.tabstop = 2
vim.o.updatetime = 250         -- speeds up the update for faster completion
vim.o.wrap = true
vim.o.linebreak = true

-- keybindings
local function nmap(keys, command, opts)
  opts = opts or {}
  vim.keymap.set('n', keys, command, opts)
end

vim.keymap.set('i', '<C-c>', '<Esc>')

nmap('<leader>q', ':q<cr>')
nmap('<leader>Q', ':qa<cr>')
nmap('<leader>r', ':r<SPACE>')
nmap('<leader>v', ':v<SPACE>')
nmap('<leader>w', ':w<cr>')
nmap('<leader>W', ':wa<cr>')
nmap('<leader><leader>', ':b#<cr>')
nmap('<leader>1', ':!<SPACE>')
nmap('<leader>,', ':e $MYVIMRC<cr>', { desc = 'Edit vimrc file' })

-- Insert blank lines w/o leaving normal mode
nmap('<leader><CR>', 'o<Esc>')
nmap('<leader><S-CR>', 'O<Esc>')

-- move up/down within wrapped lines
nmap('k', 'gk')
nmap('<up>', 'gk')
nmap('j', 'gj')
nmap('<down>', 'gj')

nmap('<cr>', ':nohlsearch<cr>', { silent = true }) -- clear highlight on carriage return

-- find
nmap('<leader>e', builtin.find_files, { desc = 'Find file' })
nmap('<leader>b', builtin.buffers, { desc = 'Find buffer' })
nmap('<leader>E', builtin.git_files, { desc = 'Find in git' })

-- git
nmap('<leader>gb', ':Git blame<cr>')

-- LSP actions
vim.api.nvim_create_autocmd('LspAttach', {
  group = vim.api.nvim_create_augroup('UserLspConfig', {}),
  callback = function(ev)
    local opts = {remap = false, silent = true, buffer = ev.buf }
    vim.keymap.set('n', '<leader>li', vim.lsp.buf.hover, opts)
    vim.keymap.set('n', '<leader>ld', vim.lsp.buf.definition, opts)
    vim.keymap.set('n', '<leader>lt', vim.lsp.buf.type_definition, opts)
    vim.keymap.set('n', '<leader>li', vim.lsp.buf.implementation, opts)
    vim.keymap.set('n', '<leader>lr', vim.lsp.buf.references, opts)
    vim.keymap.set('n', '<leader>ln', vim.lsp.buf.rename, opts)
    vim.keymap.set('n', '<leader>lf', vim.lsp.buf.code_action, opts)
    vim.keymap.set('n', '<leader>le', vim.diagnostic.open_float, opts)
end,
})

-- autocomplete with tab
vim.api.nvim_set_keymap('i', '<Tab>',   [[pumvisible() ? "\<C-p>" : "\<Tab>"]],   { noremap = true, expr = true })

-- vim-test
nmap('<leader>t', ':TestNearest<cr>', { silent = true })
nmap('<leader>T', ':TestFile<cr>', { silent = true })

-- autocommands
vim.cmd [[
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
]]
vim.cmd [[autocmd BufWritePre <buffer> lua vim.lsp.buf.format()]]

vim.cmd.colorscheme 'catppuccin'

vim.diagnostic.config({
  virtual_text = true
})
