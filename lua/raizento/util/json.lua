local M = {}

---@param path string Path of the file to open
---@param mode string Mode to open the file in
---@return file*? file handle
function M.open_json_file(path, mode)
  if not vim.endswith(path, ".json") then
    error("Path " .. path(" does not end in .json"))
  end

  local normalized_path = vim.fs.normalize(path)
  local file, err = io.open(normalized_path, mode)

  return file
end

---@param path string path to write the file to
---@param content table lua object to write to the json file
function M.write_as_json(path, content)
  local file = M.open_json_file(path, "w")
  local json = vim.json.encode(content)

  file:write(json)
  file:flush()
  return file:close()
end

---@param path string Path of the json file
---@return table object the decoded Lua table
function M.read_from_json(path)
  local file = M.open_json_file(path, "r")

  if file == nil then
    return {}
  end

  local json = file:read("*a")
  local object = vim.json.decode(json)

  return object
end

return M
