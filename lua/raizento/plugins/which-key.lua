local M = {
  "folke/which-key.nvim",
  init = function()
    vim.opt.timeout = true
    vim.opt.timeoutlen = 300
  end,
}

M.config = function()
  local whichkey = require("which-key")

  whichkey.register({
    t = "TreeSitter",
  }, { prefix = "<Leader>" })

  whichkey.register({
    g = {
      name = "Git",
      t = "Toggle",
    },
  }, { prefix = "<Leader>" })
end

return M
