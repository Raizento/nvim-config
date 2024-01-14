local M = {
  "williamboman/mason-lspconfig.nvim",
  dependencies = {
    "williamboman/mason.nvim",
  },
}

M.config = function()
  local servers = {}

  require("mason").setup({
    ui = {
      icons = {
        package_installed = "󰄵",
        package_pending = "󰪞",
        package_uninstalled = "󰄱",
      },
    },
  })

  local handlers = require("raizento.lsp.handlers")
  require("mason-lspconfig").setup({
    ensure_installed = servers,
    handlers = handlers.handlers,
  })

  vim.keymap.set("n", "<Leader>de", vim.diagnostic.open_float, { desc = "open float" })
  vim.keymap.set("n", "<Leader>dp", vim.diagnostic.goto_prev, { desc = "previous" })
  vim.keymap.set("n", "<Leader>dn", vim.diagnostic.goto_next, { desc = "next" })
  vim.keymap.set("n", "<Leader>dq", vim.diagnostic.setloclist, { desc = "open loclist" })
end

return M
