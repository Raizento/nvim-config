local M = {
  "nvim-lualine/lualine.nvim",
  dependencies = { "nvim-tree/nvim-web-devicons" },
}

M.opts = {
  sections = {
    lualine_b = {
      'branch',
      fmt = M.shorten_branch_name,
    },
  },
  options = {
      globalstatus = true,
  },
}

M.shorten_branch_name = function(text, context)
  return text:sub(1,40)
end

return M
