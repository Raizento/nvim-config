function add_diagnostic_keymaps(bufnr)
  vim.keymap.set("n", "<Leader>de", function()
    local bufnr, winid = vim.diagnostic.open_float()
    vim.bo[bufnr].filetype = "DiagnosticFloat"

    -- Prevent any other buffers to be opened in the float
    vim.wo[winid].winfixbuf = true
  end, { buffer = bufnr }, "open float")
  vim.keymap.set("n", "<Leader>dl", function()
    local bufnr = vim.api.nvim_get_current_buf()
    local diagnostics = vim.diagnostic.get(bufnr)
    vim.diagnostic.setloclist(diagnostics)
  end, { buffer = bufnr }, "load diagnostics into loclist")
  vim.keymap.set("n", "<Leader>dPq", get_diagnostics_for_project, { desc = "get diagnostics for project" })
end

function delete_diagnostic_keymaps(bufnr)
  vim.keymap.del("n", "<Leader>de", { buffer = bufnr })
  vim.keymap.del("n", "<Leader>dl", { buffer = bufnr })
  vim.keymap.del("n", "<Leader>dPq", { buffer = bufnr })
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
end, { desc = "get diagnostics in tab" })

function get_diagnostics_for_project()
  local bufnr = vim.api.nvim_get_current_buf()
  local filetype = vim.bo[bufnr].filetype

  local files = require("raizento.util.fs").find_files_of_type(vim.fn.getcwd(), { filetype })
  local iter = vim.iter(files)

  local clients = vim.lsp.get_clients()

  local diagnostics = {}

  iter:map(vim.fn.bufadd):each(function(bufnr)
    vim.fn.bufload(bufnr)
    for _, client in ipairs(clients) do
      vim.lsp.buf_attach_client(bufnr, client.id)
    end

    -- Only read diagnostics once all LSPs have been attached
    local buffer_diagnostics = vim.diagnostic.get(bufnr)
    buffer_diagnostics = unpack(buffer_diagnostics)

    table.insert(diagnostics, buffer_diagnostics)
  end)

  vim.diagnostic.setqflist(diagnostics)
end
