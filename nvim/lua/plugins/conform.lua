return {
	"stevearc/conform.nvim",
	event = { "BufWritePre" },
	cmd = { "ConformInfo" },
	opts = {
		notify_no_formatters = false,
		formatters_by_ft = {
			go = { "gofumpt", "goimports", "golines" },
			python = { "isort", "black" },
			sql = { "pg_format" },
			bash = { "beautysh" },
			yaml = { "yamlfmt" },
			toml = { "taplo" },
			lua = { "stylua" },
			nix = { "alejandra" },
			proto = { "buf" },
		},
		formatters = {
			golines = { args = { "-m", "120" } },
		},
		format_on_save = function(bufnr)
			local bufname = vim.api.nvim_buf_get_name(bufnr)

			-- disable formatting for generated files
			if bufname:match("/gen/") then
				return
			end

			return { timeout_ms = 2500, lsp_format = "fallback" }
		end,
	},
}
