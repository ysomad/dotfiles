vim.pack.add({
	"https://github.com/olexsmir/gopher.nvim",
})

require("gopher").setup({
	gotests = {
		template = "testify",
	},
})
