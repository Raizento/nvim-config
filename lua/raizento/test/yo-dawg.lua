-- TODO Really only require this for testing
local M = {
  "HiPhish/yo-dawg.nvim",
  -- This variable will be set by the test shim
  cond = function()
    return vim.g.istest
  end,
}

return M
