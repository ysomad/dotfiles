local autocmd = vim.api.nvim_create_autocmd
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

-- trim whitespace
autocmd({'BufWritePre'}, {
    pattern = '*',
    command = '%s/\\s\\+$//e',
})

local timeout_ms = 3000

-- Go: format on save
autocmd({'BufWritePre'}, {
  pattern = '*.go',
  callback = function()
    -- TODO: replace with vim.lsp.buf.format when its released
    vim.lsp.buf.formatting_sync(nil, timeout_ms) -- DEPRECATED
  end
})

-- Go: sort imports on save
autocmd({'BufWritePre'}, {
  pattern = '*.go',
  callback = function()
    local params = vim.lsp.util.make_range_params(nil, vim.lsp.util._get_offset_encoding())
    params.context = {only = {"source.organizeImports"}}
    local result = vim.lsp.buf_request_sync(0, "textDocument/codeAction", params, timeout_ms)
    for _, res in pairs(result or {}) do
      for _, r in pairs(res.result or {}) do
        if r.edit then
          vim.lsp.util.apply_workspace_edit(r.edit, vim.lsp.util._get_offset_encoding())
        else
          vim.lsp.buf.execute_command(r.command)
        end
      end
    end
  end,
})

-- Go: omnifunc
autocmd({'FileType'}, {
  pattern = 'go',
  callback = function()
    opt_local.omnifunc = 'v:lua.vim.lsp.omnifunc'
  end
})
