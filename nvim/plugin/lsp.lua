local goto_diagnostic = function(next, severity)
	return function()
		vim.diagnostic.jump({
			count = next and 1 or -1,
			float = true,
			severity = severity and vim.diagnostic.severity[severity] or nil,
		})
	end
end

vim.api.nvim_create_autocmd("LspAttach", {
	callback = function(event)
		local map = function(keys, func, desc)
			vim.keymap.set("n", keys, func, { buffer = event.buf, desc = "LSP: " .. desc })
		end

		map("gr", vim.lsp.buf.references, "[g]o to [r]eferences")
		map("gd", vim.lsp.buf.definition, "[g]o to [d]efinition")
		map("gD", vim.lsp.buf.declaration, "[g]o to [D]eclaration")
		map("gi", vim.lsp.buf.implementation, "[g]o to [i]mplementation")
		map("gt", vim.lsp.buf.type_definition, "[g]o to [t]ype definition")
		map("K", vim.lsp.buf.hover, "show documentation")

		-- actions
		map("<leader>rn", vim.lsp.buf.rename, "[r]e[n]ame")
		map("<leader>ca", vim.lsp.buf.code_action, "[c]ode [a]ctions")

		-- diagnostics
		map("<leader>d", vim.diagnostic.open_float, "show (d)iagnostics")
		map("]e", goto_diagnostic(true, vim.diagnostic.severity.ERROR), "next error")
		map("[e", goto_diagnostic(false, vim.diagnostic.severity.ERROR), "prev error")
		map("]w", goto_diagnostic(true, vim.diagnostic.severity.WARN), "next warning")
		map("[w", goto_diagnostic(false, vim.diagnostic.severity.WARN), "prev warning")
	end,
})

vim.lsp.enable({
	"lua_ls",

	"gopls",
	"golangci_lint_ls",

	"pyright",
	"nil_ls",
	-- "ts_ls",

	-- "rust_analyzer",
	-- "kotlin_lsp",

	-- "bashls",
	-- "yamlls",
	-- "dockerls",
	-- "docker_compose_language_service",
})

vim.diagnostic.config({
	-- virtual_lines = true,
	virtual_text = true,
	underline = true,
	update_in_insert = false,
	severity_sort = true,
	float = {
		border = "rounded",
		source = true,
	},
	signs = {
		text = {
			[vim.diagnostic.severity.ERROR] = "󰅚 ",
			[vim.diagnostic.severity.WARN] = "󰀪 ",
			[vim.diagnostic.severity.INFO] = "󰋽 ",
			[vim.diagnostic.severity.HINT] = "󰌶 ",
		},
		numhl = {
			[vim.diagnostic.severity.ERROR] = "ErrorMsg",
			[vim.diagnostic.severity.WARN] = "DiagnosticWarn",
		},
	},
})
