local Plugin = require("raizento.plugins.plugin")

---@type Plugin
local M = {
  url = "https://github.com/mason-org/mason.nvim",
  opts = {
    ui = {
      icons = {
        package_installed = "󰄵",
        package_pending = "󰪞",
        package_uninstalled = "󰄱",
      },
    },
  },
}

return Plugin:new(M)
