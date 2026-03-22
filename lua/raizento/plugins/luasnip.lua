local Plugin = require("raizento.plugins.plugin")

---@type Plugin
local M = {
  url = "https://github.com/L3MON4D3/LuaSnip",
  dependencies = {
    "https://github.com/rafamadriz/friendly-snippets",
  },
  setup = function()
    require("luasnip")
    require("luasnip.loaders.from_vscode").lazy_load()
  end,
}

return Plugin:new(M)
