---@type vpaw.PluginSpec
local M = {
  name = "nvim-tmux-navigation",
  url = "https://github.com/alexghergh/nvim-tmux-navigation",
  opts = {},
  keys = {
    { "n", "<C-h>", "<Cmd>NvimTmuxNavigateLeft<CR>", { desc = "h" } },
    { "n", "<C-l>", "<Cmd>NvimTmuxNavigateRight<CR>", { desc = "l" } },
    { "n", "<C-k>", "<Cmd>NvimTmuxNavigateUp<CR>", { desc = "k" } },
    { "n", "<C-j>", "<Cmd>NvimTmuxNavigateDown<CR>", { desc = "h" } },
  },
}

return M
