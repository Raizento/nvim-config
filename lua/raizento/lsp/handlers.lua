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

M.handlers = {
  -- Standard handler for LSPs which do not have a config in raizento.lsp.config
  function(server_name)
    require("lspconfig")[server_name].setup({
      capabilities = M.common_capabilities(),
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
  local config = require(module_name).config(M.common_capabilities())
  M.handlers[server_name] = config
end

return M
