local M = {}

M.config = function(capabilities, on_attach)
  return function()
    require("neodev").setup({})
    require("lspconfig").lua_ls.setup({
      capabilities = capabilities,
      on_attach = on_attach,
      settings = {
        hint = {
          enable = true,
          semicolon = "All",
        },
      }
    })
  end
end

return M
