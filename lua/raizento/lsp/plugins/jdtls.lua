local Plugin = require("raizento.plugins.plugin")

---@type Plugin
local M = {
  dependencies = {
    "https://github.com/JavaHello/spring-boot.nvim",
  },
  url = "https://github.com/mfussenegger/nvim-jdtls",
}

return Plugin:new(M)
