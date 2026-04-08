local diagnostic = require("raizento.diagnostics.util")

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

---@param severity vim.diagnostic.Severity
local function set_diagnostic_qflist(severity)
  local opts = severity and { severity = severity } or nil
  local diagnostics = vim.diagnostic.get(nil, opts)
  local qflist = vim.diagnostic.toqflist(diagnostics)
  vim.fn.setqflist(qflist)

  if not vim.tbl_isempty(qflist) then
    vim.cmd.copen()
  end
end

vim.keymap.set("n", "<Leader>dw", function()
  set_diagnostic_qflist(vim.diagnostic.severity.WARN)
end)
vim.keymap.set("n", "<Leader>di", function()
  set_diagnostic_qflist(vim.diagnostic.severity.INFO)
end)
vim.keymap.set("n", "<Leader>de", function()
  set_diagnostic_qflist(vim.diagnostic.severity.ERROR)
end)
vim.keymap.set("n", "<Leader>dh", function()
  set_diagnostic_qflist(vim.diagnostic.severity.HINT)
end)
vim.keymap.set("n", "<Leader>da", set_diagnostic_qflist)
