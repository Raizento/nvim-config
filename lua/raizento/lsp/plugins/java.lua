local Plugin = require("raizento.plugins.plugin")

---@type Plugin
local M = {
  dependencies = {
    { url = "https://github.com/mfussenegger/nvim-jdtls", name = "jdtls" },
    "https://github.com/mason-org/mason.nvim",
  },
  url = "https://github.com/JavaHello/spring-boot.nvim",
  name = "spring_boot",
}

return Plugin:new(M)
