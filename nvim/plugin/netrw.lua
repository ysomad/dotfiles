vim.keymap.set("n", "<leader>pe", function()
	local liststyle = vim.g.netrw_liststyle
	local winsize = vim.g.netrw_winsize

	vim.g.netrw_liststyle = 3
	vim.g.netrw_banner = 0
	vim.g.netrw_winsize = 15

	vim.cmd("Lexplore")

	vim.g.netrw_liststyle, vim.g.netrw_winsize = liststyle, winsize

	if vim.bo.filetype ~= "netrw" then
		return
	end
end, { silent = true, desc = "Toggle netrw filetree" })

-- netrw hardcodes "| " as its tree indent (s:treedepthstring, not configurable);
-- paint it the background color so the bars vanish but indentation is kept.
local function hide_netrw_tree_bar()
	vim.cmd("hi netrwTreeBar guifg=bg")
end

hide_netrw_tree_bar()
vim.api.nvim_create_autocmd("ColorScheme", {
	callback = hide_netrw_tree_bar,
	desc = "Keep netrw tree bars invisible",
})
