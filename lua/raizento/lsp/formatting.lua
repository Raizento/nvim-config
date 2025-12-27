local M = {}

-- TODO This will always pick the first client even if multiple are attach; let user choose which one to use
-- TODO If file for buffer has been deleted but buffer has not been deleted, this will probably cause errors
M.format_all_attached_buffers = function()
  local client = vim.lsp.get_clients({
    method = vim.lsp.protocol.Methods.textDocument_formatting,
  })[1]

  for bufnr, _ in pairs(client.attached_buffers) do
    M.format_buf(bufnr)
  end
end

M.format_project = function()
  local client = vim.lsp.get_clients({
    method = vim.lsp.protocol.Methods.textDocument_formatting,
  })[1]

  local filetypes = vim.lsp.config[client.name].filetypes
  local files = require("raizento.util.fs").find_files_of_type(client.root_dir, filetypes)

  local iter = vim.iter(files)

  iter:map(vim.fn.bufadd):each(function(bufnr)
    vim.fn.bufload(bufnr)
    vim.lsp.buf_attach_client(bufnr, client.id)
    M.format_buf(bufnr)
  end)
end

---@param bufnr integer
M.format_buf = function(bufnr)
  vim.api.nvim_buf_call(bufnr, function()
    vim.lsp.buf.format({ async = true })
  end)
end

return M
