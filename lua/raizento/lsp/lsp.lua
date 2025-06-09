local fs = require("raizento.util.fs")
local lsp = require("raizento.util.lsp")

local original_handler = vim.lsp.handlers["client/registerCapability"]

vim.lsp.handlers["client/registerCapability"] = function(err, result, ctx)
  local ret = original_handler(err, result, ctx)

  local client = vim.lsp.get_client_by_id(ctx.client_id)
  local attached_buffers = client.attached_buffers

  for bufnr, attached in pairs(attached_buffers) do
    lsp.on_attach(client, bufnr)
  end

  return ret
end

vim.lsp.config["*"] = {
  capabilities = lsp.capabilities(),
  on_attach = lsp.on_attach,
}

local config_path = vim.fn.stdpath("config")
local lsp_config_dir = config_path .. "/lsp"

local filenames = fs.find_all_files(lsp_config_dir)
vim.iter(filenames):map(vim.fs.basename):map(fs.remove_file_extension):each(vim.lsp.enable)
