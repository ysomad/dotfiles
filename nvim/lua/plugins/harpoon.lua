return {
	"ThePrimeagen/harpoon",
	branch = "harpoon2",
	dependencies = { "nvim-lua/plenary.nvim" },
	config = function()
		local harpoon = require("harpoon")
		harpoon:setup()

		vim.keymap.set("n", "<leader>a", function()
			harpoon:list():add()
		end, { desc = "Harpoon mark buffer" })
		vim.keymap.set("n", "<C-e>", function()
			harpoon.ui:toggle_quick_menu(harpoon:list())
		end, { desc = "Harpoon marks" })

		vim.keymap.set("n", "<leader>h1", function()
			harpoon:list():select(1)
		end, { desc = "Harpoon 1" })
		vim.keymap.set("n", "<leader>h2", function()
			harpoon:list():select(2)
		end, { desc = "Harpoon 2" })
		vim.keymap.set("n", "<leader>h3", function()
			harpoon:list():select(3)
		end, { desc = "Harpoon 3" })
		vim.keymap.set("n", "<leader>h4", function()
			harpoon:list():select(4)
		end, { desc = "Harpoon 4" })

		-- Toggle previous & next buffers stored within Harpoon list
		vim.keymap.set("n", "[h", function()
			harpoon:list():prev()
		end, { desc = "Harpoon prev mark" })
		vim.keymap.set("n", "]h", function()
			harpoon:list():next()
		end, { desc = "Harpoon next mark" })

		harpoon:extend({
			UI_CREATE = function(cx)
				vim.keymap.set("n", "<C-v>", function()
					harpoon.ui:select_menu_item({ vsplit = true })
				end, { buffer = cx.bufnr, desc = "Harpoon open mark in vsplit" })

				vim.keymap.set("n", "<C-s>", function()
					harpoon.ui:select_menu_item({ split = true })
				end, { buffer = cx.bufnr, desc = "Harpoon open mark in split" })
			end,
		})
	end,
}
