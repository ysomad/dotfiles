---@type vim.lsp.Config
return {
	cmd = { "gopls" },
	filetypes = { "go", "gomod", "gowork", "gotmpl" },
	root_markers = { "go.mod", "go.work", ".git" },
	settings = {
		gopls = {
			gofumpt = true,
			codelenses = {
				gc_details = false,
				generate = true,
				regenerate_cgo = true,
				run_govulncheck = true,
				test = true,
				tidy = true,
				upgrade_dependency = true,
				vendor = true,
			},
			hints = {
				assignVariableTypes = true,
				compositeLiteralFields = true,
				compositeLiteralTypes = true,
				constantValues = true,
				functionTypeParameters = true,
				parameterNames = true,
				rangeVariableTypes = true,
			},
			analyses = {
				nilness = true,
				unusedparams = true,
				unusedwrite = true,
				useany = true,
				unreachable = true,
				ST1000 = false, -- incorrect or missing package comment
				S1008 = true, -- simplify returning boolean expression
				SA5000 = true, -- assignment to nil map
				SA5007 = true, -- infinite recursion call
				ST1019 = true, -- importing the same package multiple times
				SA1000 = true, -- invalid regular expression
				SA1020 = true, -- using an invalid host:port pair with a net.Listen-related function
				SA1023 = true, -- modifying the buffer in an io.Writer implementation
				SA9001 = true, -- defers in range loops may not run when you expect them to
				ST1013 = true, -- should use constants for HTTP error codes, not magic numbers
			},
			usePlaceholders = true,
			staticcheck = true,
			directoryFilters = { "-.git", "-.vscode", "-.idea", "-.vscode-test", "-node_modules" },
		},
	},
}
