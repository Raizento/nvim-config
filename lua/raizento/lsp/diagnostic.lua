-- vim.print(vim.lsp.config[vim.lsp.get_clients()[1].name].filetypes)

function add_diagnostic_keymaps(bufnr)
  vim.keymap.set("n", "<Leader>de", vim.diagnostic.open_float, { buffer = bufnr })
end

function delete_diagnostic_keymaps(bufnr)
  vim.keymap.del("n", "<Leader>de", { buffer = bufnr })
end

vim.api.nvim_create_autocmd(
  'DiagnosticChanged',{
    callback = function(ev)
      local bufnr = ev.buf
      local diagnostics = vim.diagnostic.get(bufnr)

      if #diagnostics > 0 then
        add_diagnostic_keymaps(bufnr)
      else
        pcall( delete_diagnostic_keymaps, bufnr)
      end
    end
  }
)
