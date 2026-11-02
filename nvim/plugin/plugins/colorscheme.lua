vim.pack.add({
	"https://github.com/aktersnurra/no-clown-fiesta.nvim",
})

require("no-clown-fiesta").setup({
	theme = "light",
})
vim.cmd.colorscheme("no-clown-fiesta")
