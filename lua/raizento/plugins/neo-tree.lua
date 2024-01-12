local M = {
  "nvim-neo-tree/neo-tree.nvim",
  branch = "v3.x",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
    "MunifTanjim/nui.nvim",
  },
  keys = {
    { "<Leader>et", "<CMD>Neotree toggle<CR>", desc = "toggle" },
    { "<Leader>ef", "<CMD>Neotree focus<CR>", desc = "focus" },
  },
}

return M
