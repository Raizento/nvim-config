local M = {
  "alexghergh/nvim-tmux-navigation",
  keys = {
    { "<C-h>", "<Cmd>NvimTmuxNavigateLeft<CR>", desc = "L" },
    { "<C-j>", "<Cmd>NvimTmuxNavigateDown<CR>", desc = "J" },
    { "<C-k>", "<Cmd>NvimTmuxNavigateUp<CR>", desc = "K" },
    { "<C-l>", "<Cmd>NvimTmuxNavigateRight<CR>", desc = "R" },
  },
}

M.config = function()
  require("nvim-tmux-navigation")
end

return M
