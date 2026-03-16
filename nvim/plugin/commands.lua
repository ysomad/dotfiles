local augroup = vim.api.nvim_create_augroup
local autocmd = vim.api.nvim_create_autocmd

-- highlight on yank
autocmd("TextYankPost", {
	group = augroup("HighlightYank", { clear = true }),
	pattern = "*",
	callback = function()
		vim.highlight.on_yank({ timeout = 40, visual = true })
	end,
})

--- remove all trailing whitespace on save
autocmd("BufWritePre", {
	group = augroup("TrailingWhitespace", {}),
	pattern = "*",
	command = [[%s/\s\+$//e]],
})

-- no auto continue comments on new line
autocmd("FileType", {
	group = augroup("NoAutoComment", {}),
	callback = function()
		vim.opt_local.formatoptions:remove({ "c", "r", "o" })
	end,
})

-- 2 spaces for selected filetypes
autocmd("FileType", {
	pattern = "html,css,javascript,yaml,lua,typescript,proto,json,jsonc,nix,rust",
	callback = function()
		vim.opt_local.shiftwidth = 2
		vim.opt_local.tabstop = 2
	end,
})

-- open help in vertical split
vim.api.nvim_create_autocmd("FileType", {
	pattern = "help",
	command = "wincmd L",
})

-- auto resize splits when the terminal's window is resized
vim.api.nvim_create_autocmd("VimResized", {
	command = "wincmd =",
})

-- update all plugins
vim.api.nvim_create_user_command("PackUpdateAll", function()
	vim.pack.update()
end, { desc = "Update all plugins" })

vim.api.nvim_create_user_command("PackDeleteAll", function()
	local names = {}

	for _, plugin in ipairs(vim.pack.get()) do
		if not plugin.active and plugin.spec and plugin.spec.name then
			names[#names + 1] = plugin.spec.name
		end
	end

	table.sort(names)

	if #names == 0 then
		vim.notify("No inactive vim.pack plugins to delete", vim.log.levels.INFO)
		return
	end

	vim.pack.del(names)
end, {
	desc = "Delete all inactive vim.pack plugins",
})
