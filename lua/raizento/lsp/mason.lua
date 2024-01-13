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

  vim.api.nvim_create_autocmd("LspAttach", {
    group = vim.api.nvim_create_augroup("UserLspConfig", {}),
    callback = function(ev)
      vim.keymap.set("n", "S", vim.lsp.buf.hover, { desc = "hover", buffer = ev.buf })
      vim.keymap.set("n", "<C-S>", vim.lsp.buf.signature_help, { desc = "signature help", buffer = ev.buf })

      vim.keymap.set("n", "<Leader>lwa", vim.lsp.buf.add_workspace_folder, { desc = "add folder", buffer = ev.buf })
      vim.keymap.set(
        "n",
        "<Leader>lwr",
        vim.lsp.buf.remove_workspace_folder,
        { desc = "remove folder", buffer = ev.buf }
      )
      vim.keymap.set("n", "<Leader>lwl", function()
        print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
      end, { desc = "list folders", buffer = ev.buf })

      vim.keymap.set({ "n", "v" }, "<Leaders>la", vim.lsp.buf.code_action, { desc = "actions", buffer = ev.buf })
      vim.keymap.set("n", "<Leaders>lf", function()
        vim.lsp.buf.format({ async = true })
      end, { desc = "format", buffer = ev.buf })

      vim.keymap.set("n", "<Leader>jD", vim.lsp.buf.declaration, { desc = "declaration", buffer = ev.buf })
      vim.keymap.set("n", "<Leader>jd", vim.lsp.buf.definition, { desc = "definition", buffer = ev.buf })
      vim.keymap.set("n", "<Leader>ji", vim.lsp.buf.implementation, { desc = "implementation", buffer = ev.buf })
      vim.keymap.set("n", "<Leader>jr", vim.lsp.buf.references, { desc = "references", buffer = ev.buf })
      vim.keymap.set("n", "<Leader>jt", vim.lsp.buf.type_definition, { desc = "type definition", buffer = ev.buf })
    end,
  })
end

return M
