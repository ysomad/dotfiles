vim.pack.add({ "https://github.com/xendarboh/tuicr.nvim" })

require("tuicr").setup({
	float = {
		width = 1,
		height = 1,
	},
})

vim.keymap.set("n", "<leader>cr", "<cmd>Tuicr<cr>")
