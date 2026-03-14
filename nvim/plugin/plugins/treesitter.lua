vim.api.nvim_create_autocmd("PackChanged", {
	callback = function(ev)
		if ev.data.spec.name ~= "nvim-treesitter" then
			return
		end

		if ev.data.kind ~= "install" and ev.data.kind ~= "update" then
			return
		end

		vim.cmd.TSUpdate()
	end,
})

vim.pack.add({
	{
		src = "https://github.com/nvim-treesitter/nvim-treesitter",
		version = "main",
	},
})

require("nvim-treesitter").install({
	"go",
	"sql",
	"python",
	"rust",
	"yaml",
	"bash",
	"lua",
	"javascript",
	"typescript",
	"latex",
})
