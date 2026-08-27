vim.pack.add({
	"https://github.com/xendarboh/tuicr.nvim",
})

require("tuicr").setup({
	float = {
		width = 0.9,
		height = 0.9,
	},
})

vim.keymap.set("n", "<leader>cr", "<cmd>Tuicr<cr>", { desc = "Tuicr" })
