local M = {}

-- Do not set up rust_analyzer; rustacean does that
M.config = function(capabilities, on_attach)
  return function()
    vim.g.rustaceanvim = {
      server = {
        on_attach = function(client, bufnr)
          -- Use default keybindings used for all LSPs
          on_attach(client, bufnr)

          vim.keymap.set("n", "<Leader>lo", "<CMD>RustLsp openCargo<CR>", { desc = "open cargo file", buffer = bufnr })
          vim.keymap.set(
            "n",
            "<Leader>ld",
            "<CMD>RustLsp openDocs<CR>",
            { desc = "open documentation (docs.rs)", buffer = bufnr }
          )
          vim.keymap.set("n", "<Leader>le", "<CMD>RustLsp explainError<CR>", { desc = "explain error", buffer = bufnr })
          vim.keymap.set(
            "n",
            "<Leader>lp",
            "<CMD>RustLsp parentModule<CR>",
            { desc = "go to parent module", buffer = bufnr }
          )
        end,
      },
    }
  end
end

return M
