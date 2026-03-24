local M = {}

---@param bufnr number number of the buffer to add hook to
---@param name string Hook name. If hook with that name already exists, it will be replaced by the hook from this function call.
---@param hook function Function to add to the list of functions to execute when saving a buffer
---@return table<function> on_save The new list of hooks
function M.add_to_on_save(bufnr, name, hook)
  vim.validate("name", name, "string")
  vim.validate("hook", hook, "function")

  local on_save = vim.b[bufnr].on_save or {}

  on_save[name] = hook

  vim.b[bufnr].on_save = on_save

  return on_save
end

return M
