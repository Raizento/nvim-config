local M = {}

M.exists = function(file)
  local ok, err, code = os.rename(file, file)
  if not ok then
    if code == 13 then
      -- Permission denied, but file/dir exists
      return true
    end
  end
  return ok, err
end

return M
