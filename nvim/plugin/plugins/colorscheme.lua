vim.pack.add({
	"https://github.com/aktersnurra/no-clown-fiesta.nvim",
})

-- variant comes from ~/.config/theme, `theme <dark|light>` calls :Theme in
-- running instances. not via 'background': the scheme forces it to dark.
local function apply(variant)
	vim.g.theme_variant = variant
	require("no-clown-fiesta").setup({ theme = variant })
	vim.cmd.colorscheme("no-clown-fiesta")
	vim.api.nvim_exec_autocmds("User", { pattern = "ThemeChanged" })
end

local f = io.open(vim.fn.expand("~/.config/theme"))
apply(f and vim.trim(f:read("a")) == "light" and "light" or "dark")
if f then
	f:close()
end

vim.api.nvim_create_user_command("Theme", function(args)
	apply(args.args)
end, {
	nargs = 1,
	complete = function()
		return { "dark", "light" }
	end,
})
