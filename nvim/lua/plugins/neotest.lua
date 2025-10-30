return {
	"nvim-neotest/neotest",
	event = "VeryLazy",
	dependencies = {
		"nvim-neotest/nvim-nio",
		"nvim-treesitter/nvim-treesitter",
		"nvim-lua/plenary.nvim",
		"antoinemadec/FixCursorHold.nvim",
		{ "fredrikaverpil/neotest-golang", version = "*", dependencies = { "andythigpen/nvim-coverage" } },
	},
	config = function()
		local neotest = require("neotest")
		local neotest_golang_opts = {
			go_test_args = {
				"-v",
				"-race",
				"-count=1",
				"-timeout=60s",
				"-coverprofile=" .. vim.fn.getcwd() .. "/coverage.out",
			},
			testify_enabled = true,
		}

		---@type neotest.Config
		---@diagnostic disable-next-line: missing-fields
		neotest.setup({
			adapters = {
				require("neotest-golang")(neotest_golang_opts),
			},
		})

		require("coverage").setup({
			highlights = {
				-- TODO: link terminal colors instead
				covered = { fg = "#90a959" },
				uncovered = { fg = "#cc6666" },
			},
		})

		-- move this to keys object in LazySpec, ai?
		vim.keymap.set("n", "<leader>tn", function()
			neotest.run.run()
		end, { desc = "[t]est [n]earest" })

		vim.keymap.set("n", "<leader>tf", function()
			neotest.run.run(vim.fn.expand("%"))
		end, { desc = "[t]est run [f]ile" })

		vim.keymap.set("n", "<leader>tA", function()
			neotest.run.run(vim.uv.cwd())
		end, { desc = "[t]est [A]ll files" })

		vim.keymap.set("n", "<leader>tt", function()
			neotest.run.stop()
		end, { desc = "[t]est [t]erminate" })

		vim.keymap.set("n", "<leader>to", function()
			neotest.output.open({ enter = true, auto_close = true })
		end, { desc = "[t]est [o]output" })

		vim.keymap.set("n", "<leader>tO", function()
			neotest.output_panel.toggle()
		end, { desc = "[t]est [O]output" })

		vim.keymap.set("n", "<leader>ts", function()
			neotest.summary.toggle()
		end, { desc = "[t]est [s]ummary" })

		vim.keymap.set("n", "<leader>tw", function()
			neotest.watch.toggle()
		end, { desc = "[t]est [w]atch" })

		vim.keymap.set("n", "]t", function()
			neotest.jump.next()
		end, { desc = "next test" })

		vim.keymap.set("n", "[t", function()
			neotest.jump.prev()
		end, { desc = "prev test" })

		vim.keymap.set("n", "]T", function()
			neotest.jump.next({ status = "failed" })
		end, { desc = "next failed test" })

		vim.keymap.set("n", "]T", function()
			neotest.jump.prev({ status = "failed" })
		end, { desc = "prev failed test" })

		vim.keymap.set("n", "<leader>tc", "<cmd>Coverage<cr>", { desc = "[t]est [c]overage" })
		vim.keymap.set("n", "<leader>tC", "<cmd>CoverageClear<cr>", { desc = "[t]est [C]overage clear" })
	end,
}
