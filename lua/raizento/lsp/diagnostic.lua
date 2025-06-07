-- vim.print(vim.lsp.config[vim.lsp.get_clients()[1].name].filetypes)

function add_diagnostic_keymaps(bufnr)
  vim.keymap.set("n", "<Leader>de", vim.diagnostic.open_float, { buffer = bufnr })
end

function delete_diagnostic_keymaps(bufnr)
  vim.keymap.del("n", "<Leader>de", { buffer = bufnr })
end

vim.api.nvim_create_autocmd("DiagnosticChanged", {
  callback = function(ev)
    local bufnr = ev.buf
    local diagnostics = vim.diagnostic.get(bufnr)

    if #diagnostics > 0 then
      add_diagnostic_keymaps(bufnr)
    else
      pcall(delete_diagnostic_keymaps, bufnr)
    end
  end,
})

-- Best effort implementation at the moment;
-- will NOT switch to window in tab that location list entry is actually in
-- This is due to the way that location list jump work; see :help location-list-window
vim.keymap.set("n", "<Leader>dl", function()
  local tabpage_id = vim.api.nvim_get_current_tabpage()
  local windows = vim.iter(vim.api.nvim_tabpage_list_wins(tabpage_id))

  local buffers = windows:map(vim.api.nvim_win_get_buf)

  -- Need to flatten here to get a single list of diagnostics
  -- since each call to vim.diagnostic.get returns its own list of diagnostics
  -- Without flatten, that will be a List(List(Diagnostic))
  local diagnostics = buffers:map(vim.diagnostic.get):flatten():totable()

  if #diagnostics > 0 then
    local qf_items = vim.diagnostic.toqflist(diagnostics)
    vim.fn.setloclist(0, qf_items)
    vim.cmd([[botright lopen]])
  else
    vim.notify("No diagnostics in current tab")
  end
end)
