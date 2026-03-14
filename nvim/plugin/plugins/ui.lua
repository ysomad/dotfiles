vim.o.timeout = true
vim.o.timeoutlen = 300

vim.pack.add({
	"https://github.com/nvim-tree/nvim-web-devicons",
	"https://github.com/nvim-lualine/lualine.nvim",
	"https://github.com/folke/which-key.nvim",
	{ src = "https://github.com/nvim-treesitter/nvim-treesitter", version = "main" },
	"https://github.com/MeanderingProgrammer/render-markdown.nvim",
})

require("lualine").setup({
	options = {
		component_separators = { left = "", right = "" },
		section_separators = { left = "", right = "" },
		icons_enabled = true,
		always_divide_middle = true,
	},
	sections = {
		lualine_a = { "mode" },
		lualine_b = { { "branch", icon = "" }, "diff", "diagnostics" },
		lualine_x = { "filetype" },
		lualine_y = {},
		lualine_z = { "location" },
	},
})

require("which-key").setup({})

require("render-markdown").setup({
	html = { enabled = false },
	latex = { enabled = false },
})
