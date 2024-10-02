local M = {}

M.config = function(capabilities, on_attach)
  return function()
    require("lspconfig").lua_ls.setup({
      capabilities = capabilities,
      on_attach = on_attach,
      settings = {
        Lua = {
          hint = {
            enable = true,
            paramName = "All",
          },
        },
      },
    })
  end
end

return M
