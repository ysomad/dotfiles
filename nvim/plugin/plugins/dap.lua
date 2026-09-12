vim.pack.add({
	"https://github.com/nvim-neotest/nvim-nio",
	"https://github.com/leoluz/nvim-dap-go",
	"https://github.com/rcarriga/nvim-dap-ui",
	"https://github.com/theHamsta/nvim-dap-virtual-text",
	"https://github.com/mfussenegger/nvim-dap",
})

local dap = require("dap")
local ui = require("dapui")

require("dapui").setup()
require("dap-go").setup()
require("nvim-dap-virtual-text").setup()

-- netcoredbg launches the godot binary itself as the debuggee, everything after
-- "--" is the debuggee's argv. must be the real mach-o, not /opt/homebrew/bin/godot-mono
-- which is a bash wrapper netcoredbg cannot debug.
local godot_bin = "/Applications/Godot_mono.app/Contents/MacOS/Godot"

dap.adapters.godot = function(cb, config)
	local root = vim.fs.root(vim.fn.getcwd(), "project.godot")

	if not root then
		vim.notify("dap: no project.godot found", vim.log.levels.ERROR)
		return
	end

	local netcoredbg = vim.fn.exepath("netcoredbg")

	if netcoredbg == "" then
		vim.notify("dap: netcoredbg not found on PATH", vim.log.levels.ERROR)
		return
	end

	-- godot loads prebuilt assemblies, so the build has to land before the debuggee starts
	local build = vim.system({ "dotnet", "build" }, { cwd = root, text = true }):wait()

	if build.code ~= 0 then
		vim.notify(build.stdout or build.stderr or "dotnet build failed", vim.log.levels.ERROR)
		return
	end

	cb({
		type = "executable",
		command = netcoredbg,
		args = { "--interpreter=vscode", "--", config.godot or godot_bin, "--path", root },
		options = { cwd = root },
	})
end

dap.configurations.cs = {
	{
		type = "godot",
		name = "godot: launch project",
		request = "launch",
	},
}

vim.keymap.set("n", "<leader>b", dap.toggle_breakpoint, { desc = "Toggle breakpoint" })
vim.keymap.set("n", "<leader>gb", dap.run_to_cursor, { desc = "Run to cursor" })

vim.keymap.set("n", "<leader>?", function()
	require("dapui").eval(nil, { enter = true })
end)

vim.keymap.set("n", "<F1>", dap.continue)
vim.keymap.set("n", "<F2>", dap.step_into)
vim.keymap.set("n", "<F3>", dap.step_over)
vim.keymap.set("n", "<F4>", dap.step_out)
vim.keymap.set("n", "<F5>", dap.step_back)
vim.keymap.set("n", "<F12>", dap.restart)

dap.listeners.before.attach.dapui_config = function()
	ui.open()
end
dap.listeners.before.launch.dapui_config = function()
	ui.open()
end
dap.listeners.before.event_terminated.dapui_config = function()
	ui.close()
end
dap.listeners.before.event_exited.dapui_config = function()
	ui.close()
end
