local M = {
  "nvim-telescope/telescope.nvim",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-telescope/telescope-file-browser.nvim",
  },
  keys = {
    { "<Leader>ff", "<CMD>Telescope find_files<CR>", desc = "find files" },
    { "<Leader>fg", "<CMD>Telescope live_grep<CR>", desc = "live grep" },
    { "<Leader>fb", "<CMD>Telescope buffers<CR>", desc = "buffers" },
    { "<Leader>fh", "<CMD>Telescope help_tags<CR>", desc = "help tags" },
    { "<Leader>fc", "<CMD>Telescope commands<CR>", desc = "commands" },
    {
      "<Leader>fl",
      "<CMD>lua vim.diagnostic.setloclist({ open = false })<CR><CMD>Telescope loclist<CR>",
      desc = "loclist",
    },
    { "<Leader>ft", "<CMD>Telescope tags<CR>", desc = "tags" },
    { "<Leader>fj", "<CMD>Telescope jumplist<CR>", desc = "jumps" },
    { "<Leader>fj", "<CMD>Telescope search_history<CR>", desc = "search history" },
    { "<Leader>B", "<CMD>Telescope file_browser<CR>", desc = "telescope file browser" },
  },
}

M.config = function()
  local telescope = require("telescope")
  telescope.setup({
    extensions = {
      file_browser = {
        hijack_netrw = true,
      },
    },
  })
  telescope.load_extension("file_browser")
end

return M
