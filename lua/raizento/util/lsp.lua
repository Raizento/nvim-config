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

---@param lsp_name string: Name used to configure the lsp

---Wrap the "default" on_attach provided by nvim-lspconfig (if there is one) and our own on_attach.
---Allows us to use funtionality provided by lspconfig without having to explicitly set it anywhere.
M.wrap_on_attach = function(lsp_name)
  local lspconfig_on_attach = vim.lsp.config[lsp_name].on_attach or function(_, _) end
  return function(client, bufnr)
    lspconfig_on_attach(client, bufnr)
    M.on_attach(client, bufnr)
  end
end

--- @param lsp_name string: Name used to configure the lsp

---Merge "default" capabilities provided by nvim-lspconfig (if there are any) and our own capabilities.
---Allows us to use funtionality provided by lspconfig without having to explicitly set it anywhere.
M.merge_capabilities = function(lsp_name)
  local lspconfig_capabilities = vim.lsp.config[lsp_name].capabilities or {}
  local capabilities = vim.tbl_deep_extend("force", lspconfig_capabilities, M.capabilities())

  return capabilities
end

return M
