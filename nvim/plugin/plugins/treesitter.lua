vim.api.nvim_create_autocmd("PackChanged", {
	callback = function(ev)
		local name, kind = ev.data.spec.name, ev.data.kind
		if name == "nvim-treesitter" and kind == "update" then
			if not ev.data.active then
				vim.cmd.packadd("nvim-treesitter")
			end
			vim.cmd("TSUpdate")
		end
	end,
})

vim.pack.add({
	{
		src = "https://github.com/nvim-treesitter/nvim-treesitter",
		version = "main",
	},
}, {
	load = function(plugin)
		vim.cmd.packadd(plugin.spec.name)
		vim.opt.runtimepath:append(plugin.path .. "/runtime")
	end,
})

require("nvim-treesitter").install({
	"bash",
	"go",
	"javascript",
	"lua",
	"markdown",
	"markdown_inline",
	"python",
	"rust",
	"sql",
	"typescript",
	"tsx",
	"yaml",
})

vim.api.nvim_create_autocmd("FileType", {
	pattern = {
		"bash",
		"go",
		"javascript",
		"lua",
		"markdown",
		"python",
		"rust",
		"sh",
		"typescript",
		"yaml",
		"sql",
	},
	callback = function(ev)
		pcall(vim.treesitter.start, ev.buf)
	end,
})
