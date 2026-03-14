vim.pack.add({
	"https://github.com/folke/lazydev.nvim",
	"https://github.com/rafamadriz/friendly-snippets",
	{
		src = "https://github.com/saghen/blink.cmp",
		version = vim.version.range("1"),
	},
})

require("lazydev").setup({
	library = {
		{ path = "${3rd}/luv/library", words = { "vim%.uv" } },
	},
})

require("blink.cmp").setup({
	signature = {
		enabled = true,
		window = { show_documentation = false },
	},
	completion = {
		documentation = {
			auto_show = true,
		},
		accept = {
			auto_brackets = {
				enabled = false,
			},
		},
		menu = {
			draw = {
				columns = {
					{ "label", "label_description", gap = 1 },
					{ "kind_icon", "kind" },
					{ "source_name" },
				},
			},
		},
	},
	sources = {
		default = { "lazydev", "lsp", "path", "snippets", "buffer" },
		providers = {
			lazydev = {
				name = "LazyDev",
				module = "lazydev.integrations.blink",
				score_offset = 100,
			},
		},
	},
})
