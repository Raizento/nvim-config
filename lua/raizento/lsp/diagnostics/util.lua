local M = {}

M.get_diagnostics_for_project = function()
  local current_bufnr = vim.api.nvim_get_current_buf()
  local filetype = vim.bo[current_bufnr].filetype

  local files = require("raizento.util.fs").find_files_of_type(vim.fn.getcwd(), { filetype })
  local iter = vim.iter(files)

  local clients = vim.lsp.get_clients()

  local diagnostics = {}

  iter:map(vim.fn.bufadd):each(function(bufnr)
    vim.fn.bufload(bufnr)
    for _, client in ipairs(clients) do
      vim.lsp.buf_attach_client(bufnr, client.id)
    end

    -- Only read diagnostics once all LSPs have been attached
    local buffer_diagnostics = vim.diagnostic.get(bufnr)
    buffer_diagnostics = unpack(buffer_diagnostics)

    table.insert(diagnostics, buffer_diagnostics)
  end)

  vim.diagnostic.setqflist(diagnostics)
end

M.add_diagnostic_keymaps = function(bufnr)
  vim.keymap.set("n", "<Leader>de", vim.diagnostic.open_float, { buffer = bufnr, desc = "open float" })
  vim.keymap.set("n", "<Leader>dl", function()
    local diagnostics = vim.diagnostic.get()
    vim.diagnostic.setloclist(diagnostics)
  end, { buffer = bufnr, desc = "load diagnostics into loclist" })
  vim.keymap.set("n", "<Leader>dPq", M.get_diagnostics_for_project, { desc = "get diagnostics for project" })
end

M.delete_diagnostic_keymaps = function(bufnr)
  vim.keymap.del("n", "<Leader>de", { buffer = bufnr })
  vim.keymap.del("n", "<Leader>dl", { buffer = bufnr })
  vim.keymap.del("n", "<Leader>dPq", { buffer = bufnr })
end

return M
