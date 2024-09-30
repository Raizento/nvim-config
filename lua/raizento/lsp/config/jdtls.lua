local M = {}

M.config = function(capabilities, on_attach)
  return function()
    require("lspconfig").jdtls.setup({})
  end
end

return M
