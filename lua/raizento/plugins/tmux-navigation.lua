local M = {
  "alexghergh/nvim-tmux-navigation",
  keys = {
    { "<C-h>", "<Cmd>NvimTmuxNavigateLeft<CR>", desc = "l" },
    { "<C-j>", "<Cmd>NvimTmuxNavigateDown<CR>", desc = "j" },
    { "<C-k>", "<Cmd>NvimTmuxNavigateUp<CR>", desc = "k" },
    { "<C-l>", "<Cmd>NvimTmuxNavigateRight<CR>", desc = "r" },
  },
  opts = {},
}

return M
