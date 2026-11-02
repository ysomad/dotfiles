vim.pack.add({
	"https://github.com/nvim-lualine/lualine.nvim",
})

local opts = {
	options = {
		theme = "no-clown-fiesta-" .. vim.g.theme_variant,
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
}
require("lualine").setup(opts)

-- follow `theme <dark|light>`, see colorscheme.lua
vim.api.nvim_create_autocmd("User", {
	pattern = "ThemeChanged",
	callback = function()
		opts.options.theme = "no-clown-fiesta-" .. vim.g.theme_variant
		require("lualine").setup(opts)
	end,
})
