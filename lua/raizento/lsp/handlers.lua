-- See :h lspconfig-setup
--     :h mason-lspconfig.setup_handlers

local M = {}

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

M.lsp_keymap = function(bufnr)
  vim.keymap.set("n", "S", vim.lsp.buf.hover, { desc = "hover", buffer = bufnr })
  vim.keymap.set("n", "<C-S>", vim.lsp.buf.signature_help, { desc = "signature help", buffer = bufnr })

  vim.keymap.set("n", "<Leader>lwa", vim.lsp.buf.add_workspace_folder, { desc = "add folder", buffer = bufnr })
  vim.keymap.set("n", "<Leader>lwr", vim.lsp.buf.remove_workspace_folder, { desc = "remove folder", buffer = bufnr })
  vim.keymap.set("n", "<Leader>lwl", function()
    print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
  end, { desc = "list folders", buffer = bufnr })

  vim.keymap.set({ "n", "v" }, "<Leader>la", vim.lsp.buf.code_action, { desc = "actions", buffer = bufnr })
  vim.keymap.set("n", "<Leader>lf", function()
    vim.lsp.buf.format({ async = true })
  end, { desc = "format", buffer = bufnr })

  vim.keymap.set("n", "<Leader>jD", vim.lsp.buf.declaration, { desc = "declaration", buffer = bufnr })
  vim.keymap.set("n", "<Leader>jd", vim.lsp.buf.definition, { desc = "definition", buffer = bufnr })
  vim.keymap.set("n", "<Leader>ji", vim.lsp.buf.implementation, { desc = "implementation", buffer = bufnr })
  vim.keymap.set("n", "<Leader>jr", vim.lsp.buf.references, { desc = "references", buffer = bufnr })
  vim.keymap.set("n", "<Leader>jt", vim.lsp.buf.type_definition, { desc = "type definition", buffer = bufnr })
end

M.on_attach = function(client, bufnr)
  M.lsp_keymap(bufnr)

  if client.supports_method("textDocument/inlayHint") then
    vim.lsp.inlay_hint.enable(bufnr, true)
  end
end

M.handlers = {
  -- Standard handler for LSPs which do not have a config in raizento.lsp.config
  function(server_name)
    require("lspconfig")[server_name].setup({
      capabilities = M.common_capabilities(),
      on_attach = M.on_attach,
    })
  end,
}

local config_path = vim.fn.stdpath("config") .. "/lua/raizento/lsp/config"
local prefix = "raizento.lsp.config"

-- Grep all filenames in config_path, exclude directories
for fname in io.popen("ls -pa " .. config_path .. " | grep -v /"):lines() do
  -- Remove the .lua file name ending
  local server_name = fname:match("(.+)%..+$")
  local module_name = prefix .. "." .. server_name

  -- Pass default capabilities if servers do not want to take care of the capabilities themselves
  local config = require(module_name).config(M.common_capabilities(), M.on_attach)
  M.handlers[server_name] = config
end

return M
