-- File which contains patches to vim functions
-- Should be loaded first

local original_open_floating_window = vim.lsp.util.open_floating_preview

-- Patch internal function to set winfixbuf option
-- Prevents switching the buffer inside of the "informational" LSP/diagnostic floating windows
vim.lsp.util.open_floating_preview = function(contents, format, config)
  local bufnr, winid = original_open_floating_window(contents, format, config)
  vim.wo[winid].winfixbuf = true
  return bufnr, winid
end
