vim.pack.add({ "https://github.com/habamax/vim-godot" })

-- godot opens c# scripts in this nvim instance by spawning a short lived client:
--   nvim --server <project>/server.pipe --remote-expr "v:lua.GodotOpen('<file>',<line>,<col>)"
--
-- editor settings > dotnet > editor, external editor = Custom
--   custom exec path:      /opt/homebrew/bin/nvim
--   custom exec path args: --server {project}/server.pipe --remote-expr "v:lua.GodotOpen('{file}',{line}+1,{col}+1)"
--
-- the dotnet side hands over {line}/{col} raw 0-based, hence the +1, which godot
-- substitutes literally and nvim then evaluates as arithmetic.

local tmux_pane = vim.env.TMUX and vim.env.TMUX_PANE or nil

local function focus()
	if vim.g.godot_focus == false then
		return
	end

	if tmux_pane and vim.fn.executable("tmux") == 1 then
		vim.system({ "tmux", "select-window", "-t", tmux_pane })
		vim.system({ "tmux", "select-pane", "-t", tmux_pane })
	end

	if vim.fn.has("mac") == 1 then
		vim.system({ "open", "-a", "Alacritty" })
	end
end

-- --remote-expr evaluates vimscript, so this has to be reachable as v:lua.GodotOpen
function _G.GodotOpen(file, line, col)
	vim.schedule(function()
		-- fnameescape is required, vim.cmd.drop joins its args on spaces unescaped
		local ok, err = pcall(vim.cmd.drop, vim.fn.fnameescape(file))

		if not ok then
			vim.notify("GodotOpen: " .. tostring(err), vim.log.levels.ERROR)
			return
		end

		-- an out of range column is clamped by the api, an out of range line is not
		local lnum = math.min(math.max(tonumber(line) or 1, 1), vim.api.nvim_buf_line_count(0))
		local cnum = math.max(tonumber(col) or 1, 1)

		vim.api.nvim_win_set_cursor(0, { lnum, cnum - 1 })
		vim.cmd("normal! zz")
		focus()
	end)

	-- keep the client's stdout clean
	return ""
end

local root = vim.fs.root(vim.fn.getcwd(), "project.godot")

if not root then
	return
end

local pipe = vim.fs.joinpath(root, "server.pipe")

-- a crashed nvim leaves the socket file behind, so fs_stat alone is not proof of a listener
if vim.uv.fs_stat(pipe) then
	local ok, chan = pcall(vim.fn.sockconnect, "pipe", pipe, { rpc = true })

	if ok and chan ~= 0 then
		pcall(vim.fn.chanclose, chan)
		return
	end

	vim.uv.fs_unlink(pipe)
end

local ok, err = pcall(vim.fn.serverstart, pipe)

if not ok then
	vim.notify("godot: serverstart failed: " .. tostring(err), vim.log.levels.WARN)
end
