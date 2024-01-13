local M = {
  "neovim/nvim-lspconfig",
  dependencies = {
    "hrsh7th/cmp-nvim-lsp",
    "hrsh7th/cmp-nvim-lsp-signature-help",
  },
}

M.common_capabilities = function()
  local cmp_lsp_status, cmp_lsp = pcall(require, "cmp_nvim_lsp")
  if cmp_lsp_status then
    return cmp_lsp.default_capabilities()
  end

  local capabilities = vim.lsp.protocol.make_client_capabilities()
  capabilities.textDocument.completion.completionItem.snippetSupport = true
  capabilities.textDocument.completion.completionItem.resolveSupport = {
    properties = {
      "documentation",
      "details",
      "additionalTextEdits",
    },
  }

  return capabilities
end

M.config = function()
  local lspconfig = require("lspconfig")
end

return M
