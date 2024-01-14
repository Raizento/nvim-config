local M = {}

M.config = function(capabilities, on_attach)
  return function()
    require("rust-tools").setup({
      server = {
        on_attach = on_attach,
      },
    })
  end
end

return M
