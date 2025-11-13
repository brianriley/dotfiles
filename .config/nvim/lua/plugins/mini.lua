return {
	{
		"nvim-mini/mini.completion",
		version = false,
		config = function(_, _)
			require("mini.completion").setup()
		end,
	},
	{
		"nvim-mini/mini.indentscope",
		version = false,
		opts = {
			symbol = "│",
		},
		config = function(_, _)
			require("mini.indentscope").setup()
		end,
	},
	{
		"nvim-mini/mini.comment",
		version = false,
		config = function(_, _)
			require("mini.comment").setup()
		end,
	},
	{
		"nvim-mini/mini.surround",
		version = false,
		config = function(_, _)
			require("mini.surround").setup()
		end,
	},
	{
		"nvim-mini/mini.statusline",
		version = false,
		config = function(_, _)
			require("mini.statusline").setup()
		end,
	},
}
