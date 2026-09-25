---@type vim.lsp.Config
return {
	cmd = { "sqruff", "lsp" },
	filetypes = { "sql" },
	root_markers = { ".sqruff", ".git" },
}
