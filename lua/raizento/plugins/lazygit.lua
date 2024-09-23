local M = {
  "kdheepak/lazygit.nvim",
  dependencies = { "nvim-lua/plenary.nvim" },
  keys = {
    { "<Leader>gl", "<CMD>LazyGit<CR>", desc = "lazygit" },
  },
}

return M
