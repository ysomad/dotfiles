vim.opt_local.expandtab = false

local alt = {}

function alt.is_test_file()
	local file = vim.fn.expand("%")

	if #file <= 1 then
		vim.notify("no buffer name", vim.log.levels.ERROR)
		return nil, false, false
	end

	local is_test = string.find(file, "_test%.go$")
	local is_source = string.find(file, "%.go$")

	return file, (not is_test and is_source), is_test
end

function alt.alternate()
	local file, is_source, is_test = alt.is_test_file()
	if not file then
		return nil
	end

	local alt_file = file

	if is_test then
		alt_file = string.gsub(file, "_test.go", ".go")
	elseif is_source then
		alt_file = vim.fn.expand("%:r") .. "_test.go"
	else
		vim.notify("not a go file", vim.log.levels.ERROR)
	end

	return alt_file
end

function alt.switch(cmd)
	cmd = cmd or ""

	local alt_file = alt.alternate()

	if #cmd <= 1 then
		local ocmd = "e " .. alt_file
		vim.cmd(ocmd)
	else
		local ocmd = cmd .. " " .. alt_file
		vim.cmd(ocmd)
	end
end

vim.keymap.set("n", "<leader>ta", function()
	alt.switch()
end, { desc = "[t]est [a]lternate" })

vim.keymap.set("n", "<leader>tv", function()
	alt.switch("vsplit")
end, { desc = "[t]est alternate [v]split" })

vim.keymap.set("n", "<leader>th", function()
	alt.switch("split")
end, { desc = "[t]est alternate [h]split" })

-- go specific keymaps
vim.keymap.set("n", "<leader>ee", "oif err != nil {<CR>}<Esc>Oreturn err<Esc>")
vim.keymap.set("n", "<leader>ef", 'oif err != nil {<CR>}<Esc>Oreturn fmt.Errorf(": %w", err)<Esc>F:i')
