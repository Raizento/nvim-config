---@type vpaw.PluginSpec
local M = {
  url = "https://www.github.com/navarasu/onedark.nvim",
  setup = function()
    require("onedark").load()
  end,
}

return M
