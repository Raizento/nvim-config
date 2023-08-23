local M = {}

M.config = function(lsp_config, capabilities)
  return function()
    require("rust-tools").setup({})
  end
end

return M
