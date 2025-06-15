local M = {}

M.FILE_ENDING_REGEX = "^(%.?[^.]+).*"

---@param filepath string
---@return boolean
M.does_file_exist = function(filepath)
  return vim.uv.fs_stat(filepath) and true or false
end

---@param bufnr integer
---@return boolean
M.does_file_exist_for_bufnr = function(bufnr)
  local filepath = vim.api.nvim_buf_get_name(bufnr)
  return M.does_file_exist(filepath)
end

---@param filename string
---@return string
M.remove_file_extension = function(filename)
  -- gsub returns two results; the result string and the number of substitutions
  -- Since we don't care about the number of substitutions, only return result string
  local result, _ = filename:gsub(M.FILE_ENDING_REGEX, "%1")
  return result
end

---@param filename string
---@param filetypes string[]
---@return boolean
M.is_filetype = function(filename, filetypes)
  local iter = vim.iter(filetypes)

  return iter:any(function(filetype)
    return vim.endswith(filename, filetype)
  end)
end

---@param path string
---@param filetypes string[]
---@return string[]
M.find_files_of_type = function(path, filetypes)
  return vim.fs.find(function(name, _)
    return M.is_filetype(name, filetypes)
  end, { limit = math.huge, type = "file", path = path })
end

---@param path string: Path from which to start searching
---@return string[]
M.find_all_files = function(path)
  return vim.fs.find(function(_, _)
    return true
  end, { limit = math.huge, type = "file", path = path })
end

return M
