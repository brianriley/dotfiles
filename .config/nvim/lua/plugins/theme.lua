local vim = vim

return {
  {
    "EdenEast/nightfox.nvim",
    config = function()
      vim.cmd([[colorscheme nordfox]])
    end,
  },
}
