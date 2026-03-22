local M = {}

M.add_diagnostic_keymaps = function(bufnr)
  vim.keymap.set("n", "<Leader>de", vim.diagnostic.open_float, { buffer = bufnr, desc = "open float" })
  vim.keymap.set("n", "<Leader>dl", function()
    local diagnostics = vim.diagnostic.get()
    vim.diagnostic.setloclist(diagnostics)
  end, { buffer = bufnr, desc = "load diagnostics into loclist" })
end

M.delete_diagnostic_keymaps = function(bufnr)
  vim.keymap.del("n", "<Leader>de", { buffer = bufnr })
  vim.keymap.del("n", "<Leader>dl", { buffer = bufnr })
  vim.keymap.del("n", "<Leader>dPq", { buffer = bufnr })
end

return M
