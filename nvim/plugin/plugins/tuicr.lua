vim.pack.add({ "https://github.com/xendarboh/tuicr.nvim" })

require("tuicr").setup({
	command = vim.env.HOME .. "/bin/tuicr-nvim",
	float = {
		width = 1,
		height = 1,
	},
})

vim.keymap.set("n", "<leader>cr", "<cmd>Tuicr<cr>")
