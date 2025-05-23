local M = {
  "nvim-lualine/lualine.nvim",
  dependencies = { "nvim-tree/nvim-web-devicons" },
}

M.shorten_branch_name = function(text, context)
  if text:len() > 40 then
    return text:sub(1,37) .. "..."
  else
    return text
  end
end

M.opts = {
  sections = {
    lualine_b = {
      {
        'branch',
        fmt = M.shorten_branch_name,
      },
    },
  },
  options = {
      globalstatus = true,
  },
}

return M
