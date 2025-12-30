local M = {
  "nvim-lualine/lualine.nvim",
  dependencies = { "nvim-tree/nvim-web-devicons" },
}

require("raizento.util.string")

M.shorten_branch_name = function(text, _)
  return text:shorten(40, 3, ".")
end

M.opts = {
  sections = {
    lualine_b = {
      {
        "branch",
        fmt = M.shorten_branch_name,
      },
    },
  },
  options = {
    globalstatus = true,
  },
}

return M
