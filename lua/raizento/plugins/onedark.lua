local Plugin = require("raizento.plugins.plugin")

---@type Plugin
local M = {
  url = "https://www.github.com/navarasu/onedark.nvim",
  setup = function()
    require("onedark").load()
  end,
}


return Plugin:new(M) 
