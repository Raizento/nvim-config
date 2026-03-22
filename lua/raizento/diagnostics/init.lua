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

local diagnostic_list = {

}

vim.api.nvim_create_autocmd({ "DiagnosticChanged" }, {
  callback = function(ev)
    diagnostic_list[ev.file] = ev.data.diagnostics
  end
})

vim.keymap.set("n", "<Leader>dt", function() vim.print(diagnostic_list) end)
vim.keymap.set("n", "<Leader>dT", 
  function() 
    local sum = 0
    for _, diagnostics in pairs(diagnostic_list) do
      sum = sum + #diagnostics 
    end
    vim.print(sum)
  end)

