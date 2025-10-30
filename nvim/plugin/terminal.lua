local job_id = 0

-- Set local settings for terminal buffers
vim.api.nvim_create_autocmd("TermOpen", {
	group = vim.api.nvim_create_augroup("custom-term-open", {}),
	callback = function()
		vim.opt_local.number = false
		vim.opt_local.relativenumber = false
		vim.opt_local.scrolloff = 0

		job_id = vim.bo.channel
	end,
})

-- Easily hit escape in terminal mode.
vim.keymap.set("t", "<esc><esc>", "<c-\\><c-n>", { desc = "Close terminal" })

-- Open a terminal at the bottom of the screen with a fixed height.
vim.keymap.set("n", "<leader>pt", function()
	vim.cmd.new()
	vim.cmd.wincmd("J")
	vim.api.nvim_win_set_height(0, 12)
	vim.wo.winfixheight = true
	vim.cmd.term()
end, { desc = "Open terminal in hsplit" })

-- example of sending commands to nvim term
vim.keymap.set("n", "<leader>example", function()
	vim.fn.chansend(job_id, { "echo HELLO WORLD\r\n" })
end)
