local opt = vim.opt -- as a shorthand

-- disable the startup splash screen
opt.shortmess:append("I")

opt.nu = true
opt.relativenumber = true

opt.tabstop = 4
opt.softtabstop = 4
opt.shiftwidth = 4
opt.expandtab = true

opt.smartindent = true
opt.wrap = false
opt.smartcase = true
opt.ignorecase = true

opt.swapfile = false
opt.backup = false
opt.undodir = os.getenv("HOME") .. "/.vim/undodir"
opt.undofile = true

opt.hlsearch = false
opt.incsearch = true

opt.termguicolors = true
opt.cursorline = true

opt.scrolloff = 8
opt.signcolumn = "yes"
opt.isfname:append("@-@")

opt.updatetime = 50
opt.colorcolumn = "120"

opt.winborder = "rounded"
