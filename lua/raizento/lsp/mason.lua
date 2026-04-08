---@type vpaw.PluginSpec
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

return M
