vim.pack.add({
	"https://github.com/NvChad/nvim-colorizer.lua",
})

require("colorizer").setup({
	user_default_options = {
		names = false,
	},
})
