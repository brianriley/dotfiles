return {
  { 'nvim-mini/mini.completion', version = false },
  {
    'nvim-mini/mini.indentscope',
    version = false,
    opts = {
      symbol = '│',
    },
  },
  { 'nvim-mini/mini.comment', version = false },
  {
    'nvim-mini/mini.surround',
    version = false,
    opts = {
      mappings = {
        delete = 'ds',
        replace = 'cs',
      },
    },
  },
  { 'nvim-mini/mini.statusline', version = false },
}
