vim.pack.add({
	"https://github.com/nvim-lua/plenary.nvim",
	"https://github.com/f-person/git-blame.nvim",
	"https://github.com/kdheepak/lazygit.nvim",
})

vim.keymap.set("n", "<leader>lg", "<cmd>LazyGit<cr>", { desc = "LazyGit" })
