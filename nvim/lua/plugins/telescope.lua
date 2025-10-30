return {
	"nvim-telescope/telescope.nvim",
	event = "VimEnter",
	branch = "0.1.x",
	dependencies = {
		"nvim-lua/plenary.nvim",
		{ "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
	},
	config = function()
		local actions = require("telescope.actions")

		require("telescope").setup({
			defaults = {
				path_display = { "truncate " },
				mappings = {
					i = {
						["<C-k>"] = actions.move_selection_previous,
						["<C-j>"] = actions.move_selection_next,
						["<C-q>"] = actions.send_selected_to_qflist + actions.open_qflist,
					},
				},
			},
			pickers = {
				buffers = {
					sort_mru = true,
					mappings = {
						i = {
							["<C-d>"] = "delete_buffer",
						},
					},
				},
			},
		})

		require("telescope").load_extension("fzf")

		local builtin = require("telescope.builtin")

		vim.keymap.set("n", "<leader>ff", builtin.find_files, { desc = "Fuzzy find files" })
		vim.keymap.set("n", "<C-p>", builtin.git_files, { desc = "Fuzzy find git files" })
		vim.keymap.set("n", "<leader>fb", function()
			builtin.buffers({ sort_mru = true, ignore_current_buffer = true })
		end, { desc = "List opened buffers" })
		vim.keymap.set("n", "<leader>fg", builtin.live_grep, { desc = "Grep string" })
		vim.keymap.set("n", "<leader>fh", builtin.help_tags, { desc = "List help tags" })
		vim.keymap.set("n", "<leader>fx", builtin.treesitter, { desc = "List tresitter funcs, vars" })
		vim.keymap.set("n", "<leader>D", builtin.diagnostics, { desc = "List diagnostics" })
		vim.keymap.set("n", "<leader>/", builtin.current_buffer_fuzzy_find, { desc = "Fuzzy find in current buffer" })
		vim.keymap.set("n", "<leader>fr", builtin.lsp_references, { desc = "List references in Telescope" })
		vim.keymap.set("n", "<leader>fi", builtin.lsp_implementations, { desc = "Show implementations in Telescope" })
		vim.keymap.set("n", "<leader>ft", builtin.lsp_type_definitions, { desc = "Show definitions in Telescope" })
	end,
}
