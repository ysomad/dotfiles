vim.pack.add({ "https://github.com/Bekaboo/dropbar.nvim" })

local api = require("dropbar.api")

vim.keymap.set("n", "<Leader>;", api.pick, { desc = "Pick symbols in winbar" })
vim.keymap.set("n", "[;", api.goto_context_start, { desc = "Go to start of current context" })
vim.keymap.set("n", "];", api.select_next_context, { desc = "Select next context" })
