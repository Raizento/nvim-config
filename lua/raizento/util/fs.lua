local M = {}

M.FILE_ENDING_REGEX = "%..*$"

M.does_file_exist = function(filepath)
  return vim.uv.fs_stat(filepath) and true or false
end

M.does_file_exist_for_bufnr = function(bufnr)
  local filepath = vim.api.nvim_buf_get_name(bufnr)
  return M.does_file_exist(filepath)
end

M.get_files_in_directory = function(directory_path)
  local iter = vim.iter(vim.fs.dir(directory_path))

  local files_iter = iter:filter(
    -- Need to ignore first parameter since first parameter of vim.fs.dir is filename
    -- Second one is type
    function(_, type)
      return type == "file" and true or false
    end
  )

  return files_iter
end

M.remove_file_extension = function(filename)
  return filename:gsub(M.FILE_ENDING_REGEX, "")
end

return M
