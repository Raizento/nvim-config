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

vim.keymap.set("n", "<Leader>do", function()
  local tabpage_id = vim.api.nvim_get_current_tabpage()
  local windows = vim.iter(vim.api.nvim_tabpage_list_wins(tabpage_id))

  local buffers = windows:map(vim.api.nvim_win_get_buf)
  local diagnostics = buffers:map(vim.diagnostic.get):totable()

  if #diagnostics > 0 then
    vim.print(diagnostics[1][1])
    local qf_items = vim.diagnostic.toqflist(diagnostics[1])
    vim.fn.setloclist(0, qf_items)
  else
    vim.notify("No diagnostics in current tab")
  end
end)
