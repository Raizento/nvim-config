local diagnostic = require("raizento.lsp.diagnostics.util")

-- TODO This could proably also take care of removing the diagnostic once it's resolved; see issue https://github.com/Raizento/nvim-config/issues/22
vim.api.nvim_create_autocmd("DiagnosticChanged", {
  callback = function(ev)
    local bufnr = ev.buf
    local diagnostics = vim.diagnostic.get(bufnr)

    if #diagnostics > 0 then
      diagnostic.add_diagnostic_keymaps(bufnr)
    else
      pcall(diagnostic.delete_diagnostic_keymaps, bufnr)
    end
  end,
})

-- TODO This can probably be implemented with an autocommand on TabEnter, see :h TabEnter
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
end, { desc = "get diagnostics in tab" })
