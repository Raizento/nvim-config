local Plugin = require("raizento.plugins.plugin")

---@type Plugin
local M = {
  url = "https://github.com/nvim-lualine/lualine.nvim",
  dependencies = {
    "https://github.com/nvim-tree/nvim-web-devicons",
  },
  opts = {
    options = {
      globalstatus = true,
    },
  },
}

return Plugin:new(M)
