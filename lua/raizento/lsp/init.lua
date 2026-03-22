local lsp = require("raizento.lsp.util")

local original_handler = vim.lsp.handlers["client/registerCapability"]

--- Needed when LSP dynamically registers capabilities
vim.lsp.handlers["client/registerCapability"] = function(err, result, ctx)
  local ret = original_handler(err, result, ctx)

  local client = vim.lsp.get_client_by_id(ctx.client_id)

  if client == nil then
    return
  end

  local attached_buffers = client.attached_buffers

  for bufnr, _ in pairs(attached_buffers) do
    lsp.attach(client, bufnr)
  end

  return ret
end

--- If server does not dynamically register capabilities, this is needed so that the attach function gets called
vim.api.nvim_create_autocmd("LspAttach", {
  callback = function(ev)
    local client = vim.lsp.get_client_by_id(ev.data.client_id)

    if client == nil then
      return
    end

    local bufnr = ev.buf

    lsp.attach(client, ev.buf)
  end
})

local lsp_names = lsp.get_mason_lsp_names()

for _, lsp_name in ipairs(lsp_names) do
  vim.lsp.config(lsp_name, {
    -- Capabilities automatically get merged
    capabilities = require("cmp_nvim_lsp").default_capabilities(),
  })

  vim.lsp.enable(lsp_name)
end
