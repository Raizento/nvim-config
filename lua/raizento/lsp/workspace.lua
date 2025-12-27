local M = {}

---@param client vim.lsp.Client
---@param bufnr number
M.add_keymap_for_capabilities = function(client, bufnr)
  if client:supports_method(vim.lsp.protocol.Methods.workspace_workspaceFolders) then
    vim.keymap.set("n", "<Leader>lwa", vim.lsp.buf.add_workspace_folder, { desc = "add folder", buffer = bufnr })
    vim.keymap.set("n", "<Leader>lwr", vim.lsp.buf.remove_workspace_folder, { desc = "remove folder", buffer = bufnr })
    vim.keymap.set("n", "<Leader>lwl", function()
      print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
    end, { desc = "list folders", buffer = bufnr })
  end
end

return M
