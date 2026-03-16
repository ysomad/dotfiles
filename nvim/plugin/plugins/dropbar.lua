vim.pack.add({ "https://github.com/Bekaboo/dropbar.nvim" })

local api = require("dropbar.api")

for _, group in ipairs({
	"WinBar",
	"WinBarNC",
	"DropBarIconUISeparator",
	"DropBarCurrentContext",
	"DropBarMenuCurrentContext",
	"DropBarMenuNormalFloat",
	"DropBarMenuFloatBorder",
	"DropBarMenuHoverEntry",
	"DropBarMenuHoverIcon",
	"DropBarMenuHoverSymbol",
}) do
	vim.api.nvim_set_hl(0, group, { bg = "NONE" })
end

vim.api.nvim_set_hl(0, "DropBarMenuCursor", { blend = 100, nocombine = true })

vim.keymap.set("n", "<leader>;", api.pick, { desc = "Pick symbols in winbar" })
vim.keymap.set("n", "[;", api.goto_context_start, { desc = "Go to start of current context" })
vim.keymap.set("n", "];", api.select_next_context, { desc = "Select next context" })
