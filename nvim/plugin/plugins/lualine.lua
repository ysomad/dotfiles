vim.pack.add({
	"https://github.com/nvim-lualine/lualine.nvim",
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
