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
	pattern = "xml,html,xhtml,css,scss,javascript,yaml,htmljinja,lua,typescript,tsx,proto,json,jsonc,nix",
	callback = function()
		vim.opt_local.shiftwidth = 2
		vim.opt_local.tabstop = 2
	end,
})

-- treesitter syntax highlighting
autocmd("FileType", {
	pattern = { "go,sql,python,yaml,bash,lua,javascript,typescript,tsx" },
	callback = function()
		vim.treesitter.start()
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
