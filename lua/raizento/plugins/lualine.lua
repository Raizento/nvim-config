---@type vpaw.PluginSpec
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

return M
