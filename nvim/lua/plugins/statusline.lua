return {
	"nvim-lualine/lualine.nvim",
	opts = {
		options = {
			component_separators = { left = "", right = "" },
			section_separators = { left = "", right = "" },
			icons_enabled = true,
			always_divide_middle = true,
		},
		sections = {
			lualine_a = { "mode" },
			lualine_b = { { "branch", icon = "" }, "diff", "diagnostics" },
			lualine_c = { "%=", { "filename", file_status = true, path = 1 } },
			lualine_x = { "filetype" },
			lualine_y = {},
			lualine_z = { "location" },
		},
	},
	config = function(_, opts)
		require("lualine").setup(opts)
	end,
}
