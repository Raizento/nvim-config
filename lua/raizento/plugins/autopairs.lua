local M = {
  "windwp/nvim-autopairs",
  event = "InsertEnter",
  dependencies = {
    "hrsh7th/nvim-cmp",
  },
}

-- TODO add rules with TreeSitter support?
M.config = function()
  require("nvim-autopairs").setup({})
  local cmp = require("cmp")
  local autopairs = require("nvim-autopairs.completion.cmp")

  cmp.event:on("confirm_done", autopairs.on_confirm_done())
end

return M
