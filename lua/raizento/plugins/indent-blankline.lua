local M = {
  "lukas-reineke/indent-blankline.nvim",
  dependencies = {
    "nvim-treesitter/nvim-treesitter",
  },
  main = "ibl",
  opts = {
    scope = {
      show_start = false,
      show_end = false,
    },
  },
}

return M
