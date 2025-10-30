return {
	"nvim-treesitter/nvim-treesitter",
	event = { "BufReadPost", "BufNewFile" },
	build = ":TSUpdate",
	config = function()
		require("nvim-treesitter.configs").setup({
			ensure_installed = {
				"yaml",
				"toml",
				"bash",
				"dockerfile",
				"vimdoc",
				"vim",
				"comment",
				"html",
				"regex",

				"go",
				"gotmpl",
				"gomod",
				"gowork",
				"gosum",

				"lua",
				"luadoc",

				"python",
				"sql",
				"javascript",
				"typescript",
				"rust",
				"markdown",
				"kotlin",
			},
			highlight = {
				enable = true,
				additional_vim_regex_highlighting = false,
			},
			indent = { enable = true },
		})
	end,
}
