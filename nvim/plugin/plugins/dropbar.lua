vim.pack.add({ "https://github.com/Bekaboo/dropbar.nvim" })

require("dropbar").setup()

local api = require("dropbar.api")

vim.api.nvim_set_hl(0, "WinBar", { bg = "NONE" })
vim.api.nvim_set_hl(0, "WinBarNC", { bg = "NONE" })
vim.api.nvim_set_hl(0, "DropBarIconUISeparator", { bg = "NONE" })
vim.api.nvim_set_hl(0, "DropBarCurrentContext", { bg = "NONE" })
vim.api.nvim_set_hl(0, "DropBarMenuCurrentContext", { bg = "NONE" })
vim.api.nvim_set_hl(0, "DropBarMenuNormalFloat", { bg = "NONE" })
vim.api.nvim_set_hl(0, "DropBarMenuFloatBorder", { bg = "NONE" })

vim.keymap.set("n", "<Leader>;", api.pick, { desc = "Pick symbols in winbar" })
vim.keymap.set("n", "[;", api.goto_context_start, { desc = "Go to start of current context" })
vim.keymap.set("n", "];", api.select_next_context, { desc = "Select next context" })
