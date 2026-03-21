vim.pack.add({
	"https://github.com/nvim-neotest/nvim-nio",
	"https://github.com/nvim-lua/plenary.nvim",
	"https://github.com/antoinemadec/FixCursorHold.nvim",
	"https://github.com/andythigpen/nvim-coverage",
	"https://github.com/fredrikaverpil/neotest-golang",
	"https://github.com/nvim-neotest/neotest",
	"https://github.com/nvim-neotest/neotest-python",
})

vim.api.nvim_create_autocmd("VimEnter", {
	once = true,
	callback = function()
		local neotest = require("neotest")
		local neotest_golang_opts = {
			go_test_args = {
				"-v",
				"-count=1",
				"-timeout=60s",
				"-coverprofile=" .. vim.fn.getcwd() .. "/coverage.out",
			},
			testify_enabled = true,
		}

		neotest.setup({
			adapters = {
				require("neotest-golang")(neotest_golang_opts),
				require("neotest-python"),
			},
		})

		require("coverage").setup({
			highlights = {
				covered = { fg = "#90a959" },
				uncovered = { fg = "#cc6666" },
			},
		})
	end,
})

vim.keymap.set("n", "<leader>tn", function()
	require("neotest").run.run()
end, { desc = "[t]est [n]earest" })

vim.keymap.set("n", "<leader>tf", function()
	require("neotest").run.run(vim.fn.expand("%"))
end, { desc = "[t]est run [f]ile" })

vim.keymap.set("n", "<leader>tA", function()
	require("neotest").run.run(vim.uv.cwd())
end, { desc = "[t]est [A]ll files" })

vim.keymap.set("n", "<leader>tt", function()
	require("neotest").run.stop()
end, { desc = "[t]est [t]erminate" })

vim.keymap.set("n", "<leader>to", function()
	require("neotest").output.open({ enter = true, auto_close = true })
end, { desc = "[t]est [o]output" })

vim.keymap.set("n", "<leader>tO", function()
	require("neotest").output_panel.toggle()
end, { desc = "[t]est [O]output" })

vim.keymap.set("n", "<leader>ts", function()
	require("neotest").summary.toggle()
end, { desc = "[t]est [s]ummary" })

vim.keymap.set("n", "<leader>tw", function()
	require("neotest").watch.toggle()
end, { desc = "[t]est [w]atch" })

vim.keymap.set("n", "]t", function()
	require("neotest").jump.next()
end, { desc = "next test" })

vim.keymap.set("n", "[t", function()
	require("neotest").jump.prev()
end, { desc = "prev test" })

vim.keymap.set("n", "]T", function()
	require("neotest").jump.next({ status = "failed" })
end, { desc = "next failed test" })

vim.keymap.set("n", "[T", function()
	require("neotest").jump.prev({ status = "failed" })
end, { desc = "prev failed test" })

vim.keymap.set("n", "<leader>tc", "<cmd>Coverage<cr>", { desc = "[t]est [c]overage" })
vim.keymap.set("n", "<leader>tC", "<cmd>CoverageClear<cr>", { desc = "[t]est [C]overage clear" })
