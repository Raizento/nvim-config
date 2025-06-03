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

---@param bufnr number
M.enable_inlay_hints = function(bufnr)
  vim.lsp.inlay_hint.enable(true)
  vim.keymap.set("n", "<Leader>li", function()
    vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())
  end, { desc = "toggle inlay hints", buffer = bufnr })
end

return M
