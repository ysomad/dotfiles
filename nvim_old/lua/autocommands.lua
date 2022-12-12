local autocmd = vim.api.nvim_create_autocmd
local augroup = vim.api.nvim_create_augroup
local opt = vim.opt
local opt_local = vim.opt_local

-- don't auto commenting new lines
autocmd({'BufEnter'}, {
  pattern = '*',
  callback = function()
    opt.fo:remove('c')
    opt.fo:remove('r')
    opt.fo:remove('o')
  end
})

-- 2 spaces for selected filetypes
autocmd({'FileType'}, {
  pattern = 'xml,html,xhtml,css,scss,javascript,lua,yaml,htmljinja',
  callback = function()
    opt_local.shiftwidth = 2
    opt_local.tabstop = 2
  end
})

--- remove all trailing whitespace on save
local TrimWhiteSpaceGrp = augroup('TrimWhiteSpaceGrp', {})
autocmd('BufWritePre', {
	group = TrimWhiteSpaceGrp,
  pattern = '*',
  command = '%s/\\s\\+$//e',
})

local YankHighlightGrp = augroup('YankHighlightGrp', {})
autocmd('TextYankPost', {
	group = YankHighlightGrp,
  pattern = '*',
  callback = function()
    vim.highlight.on_yank({
      higroup = 'IncSearch',
      timeout = 40,
    })
  end,
})

-- go: format on save
autocmd('BufWritePre', {
  pattern = { '*.go' },
  callback = function()
    vim.lsp.buf.format({ async=true })
  end
})

-- go: sort imports on save
local function org_imports()
  local clients = vim.lsp.buf_get_clients()
  for _, client in pairs(clients) do

    local params = vim.lsp.util.make_range_params(nil, client.offset_encoding)
    params.context = {only = {"source.organizeImports"}}

    local result = vim.lsp.buf_request_sync(0, "textDocument/codeAction", params, 5000)
    for _, res in pairs(result or {}) do
      for _, r in pairs(res.result or {}) do
        if r.edit then
          vim.lsp.util.apply_workspace_edit(r.edit, client.offset_encoding)
        else
          vim.lsp.buf.execute_command(r.command)
        end
      end
    end
  end
end

autocmd('BufWritePre', {
  pattern = { '*.go' },
  callback = org_imports,
})

-- go: omnifunc
autocmd({'FileType'}, {
  pattern = 'go',
  callback = function()
    opt_local.omnifunc = 'v:lua.vim.lsp.omnifunc'
  end
})
