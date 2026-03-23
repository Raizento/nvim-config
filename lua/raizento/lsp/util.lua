local M = {}

---@param client vim.lsp.Client
---@param bufnr number
M.on_attach = function(client, bufnr)
  require("raizento.lsp.textdocument").add_keymap_for_capabilities(client, bufnr)
end

---@param client vim.lsp.Client Client for which to call the attach functions
---@param bufnr number Buffer to which the client is attached
M.attach = function(client, bufnr)
  vim.validate("bufnr", bufnr, "number")

  -- attach function might be null if neither lspconfig nor lsp/<server>.lua provide a function
  local client_on_attach = client.config.on_attach or function(_, _) end
  client_on_attach(client, bufnr)

  M.on_attach(client, bufnr)
end

---@return string[] lsp_names Names of LSPs currently installed by Mason
M.get_mason_lsp_names = function()
  ---@type table<Package>
  local packages = require("mason-registry").get_installed_packages()

  return vim
    .iter(packages)
    ---@param package Package
    :map(function(package)
      return package.spec
    end)
    ---@param spec RegistryPackageSpec
    :filter(function(spec)
      return vim.tbl_contains(spec.categories, "LSP")
    end)
    :filter(function(spec)
      -- Some packages (like vscode-spring-boot-tools) are marked as LSPs but don't have an lspconfig equivalent; these need to be filtered out
      return spec.neovim and true or false
    end)
    ---@param spec RegistryPackageSpec
    :map(function(spec)
      return spec.neovim.lspconfig
    end)
    :totable()
end

return M
