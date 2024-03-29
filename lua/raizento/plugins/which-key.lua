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
    e = {
      name = "Explorer",
    },
  }, { prefix = "<Leader>" })

  whichkey.register({
    f = {
      name = "Find",
    },
  }, { prefix = "<Leader>" })

  whichkey.register({
    m = "Markdown",
  }, { prefix = "<Leader>" })

  whichkey.register({
    g = {
      name = "Git",
      t = "Toggle",
    },
  }, { prefix = "<Leader>" })

  whichkey.register({
    j = "Jump to",
  }, { prefix = "<Leader>" })

  whichkey.register({
    d = "Diagnostics",
  }, { prefix = "<Leader>" })

  whichkey.register({
    l = {
      name = "LSP",
      w = "Workspace",
    },
  }, { prefix = "<Leader>" })
end

return M
