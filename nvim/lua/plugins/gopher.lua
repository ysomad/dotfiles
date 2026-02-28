return {
	"olexsmir/gopher.nvim",
	ft = "go",
	config = function()
		require("gopher").setup({
			gotests = {
				template = "testify",
			},
		})
	end,
}
