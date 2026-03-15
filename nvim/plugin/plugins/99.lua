vim.pack.add({
	"https://github.com/ThePrimeagen/99",
})

local _99 = require("99")
local telescope_99 = require("99.extensions.telescope")

_99.setup({
	provider = _99.Providers.OpenCodeProvider,
	model = "openai/gpt-5.4",
	-- logger = {
	-- 	level = _99.DEBUG,
	-- 	type = "file",
	-- 	path = "/tmp/99.debug",
	-- 	print_on_error = true,
	-- },
})

vim.keymap.set("n", "<leader>99", function()
	_99.vibe()
end, { desc = "99 vibe" })

vim.keymap.set("n", "<leader>9s", function()
	_99.search()
end, { desc = "99 search" })

vim.keymap.set("v", "<leader>9v", function()
	_99.visual()
end, { desc = "99 visual edit" })

vim.keymap.set("n", "<leader>9l", function()
	_99.view_logs()
end, { desc = "99 view logs" })

vim.keymap.set({ "n", "v" }, "<leader>9x", function()
	_99.stop_all_requests()
end, { desc = "99 stop requests" })

vim.keymap.set("n", "<leader>9c", function()
	_99.clear_previous_requests()
end, { desc = "99 clear history" })

vim.keymap.set("n", "<leader>9i", function()
	_99.info()
end, { desc = "99 info" })

vim.keymap.set("n", "<leader>9m", function()
	telescope_99.select_model()
end, { desc = "99 select model" })

vim.keymap.set("n", "<leader>9p", function()
	telescope_99.select_provider()
end, { desc = "99 select provider" })
