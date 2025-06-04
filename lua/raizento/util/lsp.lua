local M = {}

M.capabilities = function()
  local cmp_lsp_status, cmp_lsp = pcall(require, "cmp_nvim_lsp")
  if cmp_lsp_status then
    return cmp_lsp.default_capabilities()
  end

  return vim.lsp.protocol.make_client_capabilities()
end

---@param client vim.lsp.Client
---@param bufnr number
M.on_attach = function(client, bufnr)
  require("raizento.lsp.textdocument").add_keymap_for_capabilities(client, bufnr)
  require("raizento.lsp.workspace").add_keymap_for_capabilities(client, bufnr)
end

return M
