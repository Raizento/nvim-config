local M = {}

-- TODO This definitely needs to get refactored
---@param client vim.lsp.Client
---@param bufnr number
M.add_keymap_for_capabilities = function(client, bufnr)
  if client:supports_method(vim.lsp.protocol.Methods.textDocument_hover) then
    vim.keymap.set("n", "S", vim.lsp.buf.hover, { desc = "hover", buffer = bufnr })
  end

  if client:supports_method(vim.lsp.protocol.Methods.textDocument_signatureHelp) then
    vim.keymap.set("n", "<C-S>", vim.lsp.buf.signature_help, { desc = "signature help", buffer = bufnr })
  end

  if client:supports_method(vim.lsp.protocol.Methods.textDocument_inlayHint) then
    require("raizento.util.lsp").enable_inlay_hints(bufnr)
  end

  if client:supports_method(vim.lsp.protocol.Methods.textDocument_rename) then
    vim.keymap.set("n", "<Leader>lr", vim.lsp.buf.rename, { desc = "rename", buffer = bufnr })
  end

  if client:supports_method(vim.lsp.protocol.Methods.textDocument_references) then
    vim.keymap.set("n", "<Leader>jr", vim.lsp.buf.references, { desc = "references", buffer = bufnr })
  end

  if client:supports_method(vim.lsp.protocol.Methods.textDocument_declaration) then
    vim.keymap.set("n", "<Leader>jD", vim.lsp.buf.declaration, { desc = "declaration", buffer = bufnr })
  end

  if client:supports_method(vim.lsp.protocol.Methods.textDocument_definition) then
    vim.keymap.set("n", "<Leader>jd", vim.lsp.buf.definition, { desc = "definition", buffer = bufnr })
  end

  if client:supports_method(vim.lsp.protocol.Methods.textDocument_implementation) then
    vim.keymap.set("n", "<Leader>ji", vim.lsp.buf.implementation, { desc = "implementation", buffer = bufnr })
  end

  if client:supports_method(vim.lsp.protocol.Methods.textDocument_implementation) then
    vim.keymap.set("n", "<Leader>ji", vim.lsp.buf.implementation, { desc = "implementation", buffer = bufnr })
  end

  if client:supports_method(vim.lsp.protocol.Methods.textDocument_typeDefinition) then
    vim.keymap.set("n", "<Leader>jt", vim.lsp.buf.type_definition, { desc = "type definition", buffer = bufnr })
  end

  if client:supports_method(vim.lsp.protocol.Methods.textDocument_formatting) then
    vim.keymap.set("n", "<Leader>lf", function()
      vim.lsp.buf.format({ async = true })
    end, { desc = "format", buffer = bufnr })
  end

  if client:supports_method(vim.lsp.protocol.Methods.textDocument_codeAction) then
    vim.keymap.set({ "n", "v" }, "<Leader>la", vim.lsp.buf.code_action, { desc = "actions", buffer = bufnr })
  end
end

return M
