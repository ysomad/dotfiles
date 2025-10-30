return {
	"joshuavial/aider.nvim",
	config = function()
		require("aider").setup({
			auto_manage_context = false,
			default_bindings = false,
			debug = false,
		})

		vim.keymap.set("n", "<leader>Ao", function()
			vim.cmd("AiderOpen")
			vim.cmd("wincmd L")
		end, { desc = "Open Aider in right vsplit" })
	end,
}
