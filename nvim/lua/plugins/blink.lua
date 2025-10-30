return {
	{
		"saghen/blink.cmp",
		dependencies = { "rafamadriz/friendly-snippets" },
		version = "1.*",
		---@module 'blink.cmp'
		---@type blink.cmp.Config
		opts = {
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
				default = { "lsp", "path", "snippets", "buffer" },
			},
		},
	},
}
