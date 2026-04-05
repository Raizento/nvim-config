---@type vpaw.PluginSpec
local M = {
  url = "https://github.com/lukas-reineke/indent-blankline.nvim",
  name = "ibl",
  dependencies = {
    "https://github.com/nvim-treesitter/nvim-treesitter",
  },
  opts = {
    scope = {
      show_start = false,
      show_end = false,
    },
  },
}

return M
