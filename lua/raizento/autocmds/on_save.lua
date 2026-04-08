vim.api.nvim_create_autocmd("BufWritePre", {
  callback = function(ev)
    local buf_options = vim.b[ev.buf]

    local on_save = buf_options.on_save or {}

    for _, hook in pairs(on_save) do
      hook(ev)
    end
  end,
})
