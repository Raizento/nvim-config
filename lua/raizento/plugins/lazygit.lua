local M = {
  "kdheepak/lazygit.nvim",
  dependencies = { "nvim-lua/plenary.nvim", "nvim-telescope/telescope.nvim" },
  keys = {
    { "<Leader>gl", "<CMD>LazyGit<CR>", desc = "lazygit" },
  },
}

M.config = function()
  require("telescope").load_extension("lazygit")
end

return M
