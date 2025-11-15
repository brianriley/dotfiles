local vim = vim

vim.api.nvim_create_autocmd("LspAttach", {
  group = vim.api.nvim_create_augroup("UserLspConfig", {}),
  callback = function(ev)
    local opts = { remap = false, silent = true, buffer = ev.buf }
    vim.keymap.set("n", "<leader>li", vim.lsp.buf.hover, opts)
    vim.keymap.set("n", "<leader>ld", vim.lsp.buf.definition, opts)
    vim.keymap.set("n", "<leader>lt", "<cmd>Telescope lsp_type_definitions<cr>", opts)
    vim.keymap.set("n", "<leader>lI", vim.lsp.buf.implementation, opts)
    vim.keymap.set("n", "<leader>lr", "<cmd>Telescope lsp_references<cr>", opts)
    vim.keymap.set("n", "<leader>ln", vim.lsp.buf.rename, opts)
    vim.keymap.set("n", "<leader>la", vim.lsp.buf.code_action, opts)
    vim.keymap.set("n", "<leader>le", vim.diagnostic.open_float, opts)
  end,
})

-- LSP diagnostics
local signs = {
  Error = " ",
  Warn = " ",
  Hint = "󰌵 ",
  Info = " ",
}

local signConf = {
  text = {},
  texthl = {},
  numhl = {},
}

for type, icon in pairs(signs) do
  local severityName = string.upper(type)
  local severity = vim.diagnostic.severity[severityName]
  local hl = "DiagnosticSign" .. type
  signConf.text[severity] = icon
  signConf.texthl[severity] = hl
  signConf.numhl[severity] = hl
end

vim.diagnostic.config({
  signs = signConf,
  virtual_text = true,
})

vim.cmd([[
  highlight DiagnosticUnderlineError gui=undercurl guisp=Red
  highlight DiagnosticUnderlineWarn gui=undercurl guisp=Orange
  highlight DiagnosticUnderlineInfo gui=undercurl guisp=LightBlue
  highlight DiagnosticUnderlineHint gui=undercurl guisp=LightGrey
]])
