return {
	"nvim-treesitter/nvim-treesitter",
	lazy = false,
	branch = "main",
	build = ":TSUpdate",
	config = function()
		require("nvim-treesitter").install({
			"go",
			"sql",
			"python",
			"rust",
			"yaml",
			"bash",
			"lua",
			"javascript",
			"typescript",
			"latex",
		})
	end,
}
