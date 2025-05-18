local M = {}

M.does_file_exist_for_bufnr = function(bufnr)
  local filepath = vim.api.nvim_buf_get_name(bufnr)
  local does_file_exist, _ = pcall(vim.uv.fs_stat, filepath)
  return does_file_exist
end

return M
