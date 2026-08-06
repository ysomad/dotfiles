vim.pack.add({ "https://github.com/habamax/vim-godot" })

-- godot connects to this socket to open scripts in the running nvim instance:
-- --server ./server.pipe --remote-send "<C-\><C-N>:n {file}<CR>{line}G{col}|"
local root = vim.fs.root(vim.fn.getcwd(), "project.godot")

if root then
	local pipe = vim.fs.joinpath(root, "server.pipe")

	if not vim.uv.fs_stat(pipe) then
		pcall(vim.fn.serverstart, pipe)
	end
end
