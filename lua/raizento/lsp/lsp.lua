local lsp = require("raizento.util.lsp")

local original_handler = vim.lsp.handlers["client/registerCapability"]

vim.lsp.handlers["client/registerCapability"] = function(err, result, ctx)
  local ret = original_handler(err, result, ctx)

  local client = vim.lsp.get_client_by_id(ctx.client_id)

  if client == nil then
    return
  end

  local attached_buffers = client.attached_buffers

  for bufnr, _ in pairs(attached_buffers) do
    client.config.on_attach(client, bufnr)
  end

  return ret
end

local packages = require("mason-registry").get_installed_packages()

local lsp_names = vim
  .iter(packages)
  :map(function(package)
    return package.spec
  end)
  :filter(function(spec)
    return vim.tbl_contains(spec.categories, "LSP")
  end)
  :map(function(spec)
    return spec.neovim.lspconfig
  end)
  :totable()

for _, lsp_name in ipairs(lsp_names) do
  local on_attach = lsp.wrap_on_attach(lsp_name)
  local capabilities = lsp.merge_capabilities(lsp_name)

  vim.lsp.config(lsp_name, {
    on_attach = on_attach,
    capabilities = capabilities,
  })

  vim.lsp.enable(lsp_name)
end
