local Plugin = require("raizento.plugins.plugin")

---@type Plugin
local M = {
  url = "https://github.com/folke/lazydev.nvim",
  opts = {
    library = {
      -- See the configuration section for more details
      -- Load luvit types when the `vim.uv` word is found
      { path = "${3rd}/luv/library", words = { "vim%.uv" } },
    },
  },
}

return Plugin:new(M)
