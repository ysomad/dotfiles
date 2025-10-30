-- utils
vim.keymap.set(
	"n",
	"<leader>s",
	[[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]],
	{ desc = "Rename in curr buffer" }
)
vim.keymap.set("n", "<leader>x", "<cmd>!chmod +x %<CR>", { desc = "chmod +x curr file" })
vim.keymap.set("n", "<leader>pv", vim.cmd.Ex, { desc = "Open netrw" })

-- giga yankers and pasters
vim.keymap.set("x", "<leader>p", [["_dP]], { desc = "Paste from system clipboard" })
vim.keymap.set({ "n", "v" }, "<leader>d", [["_d]], { desc = "Del and yank into system clipboard" })
vim.keymap.set({ "n", "v" }, "<leader>y", [["+y]], { desc = "Yank into system clipboard" })
vim.keymap.set("n", "<leader>Y", [["+Y]], { desc = "Yank curr line into system clipboard" })

-- better indenting
vim.keymap.set("v", "<", "<gv", { desc = "Indent v-block to right" })
vim.keymap.set("v", ">", ">gv", { desc = "Indent v-block to left" })

-- disable Q
vim.keymap.set("n", "Q", "<nop>")

-- disable arrows
vim.keymap.set({ "n", "i" }, "<up>", "")
vim.keymap.set({ "n", "i" }, "<down>", "")
vim.keymap.set({ "n", "i" }, "<left>", "")
vim.keymap.set({ "n", "i" }, "<right>", "")

-- center screen on Ctrl+u, Ctrl+d moves
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")

-- center screen on next
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")

-- move between buffers
vim.keymap.set("n", "[b", "<cmd>bprevious<cr>", { desc = "Prev buffer" })
vim.keymap.set("n", "]b", "<cmd>bnext<cr>", { desc = "Next buffer" })

-- change split sizes
vim.keymap.set("n", "<C-Left>", "<c-w>5<", { desc = "Move split to left" })
vim.keymap.set("n", "<C-Right>", "<c-w>5>", { desc = "Move split to right" })
vim.keymap.set("n", "<C-Up>", "<C-W>-", { desc = "Make split taller" })
vim.keymap.set("n", "<C-Down>", "<C-W>+", { desc = "Make split shorter" })

-- Duplicate line and comment first one
vim.keymap.set(
	"n",
	"ycc",
	'"yy" . v:count1 . "gcc\']p"',
	{ desc = "Copy line, comment first", remap = true, expr = true }
)
