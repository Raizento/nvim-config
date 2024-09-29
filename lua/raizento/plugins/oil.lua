local M = {
  'stevearc/oil.nvim',
  ---@module 'oil'
  ---@type oil.SetupOpts
  opts = {},
  -- Optional dependencies
  dependencies = { "nvim-tree/nvim-web-devicons" }, -- use if prefer nvim-web-devicons
  keys = {
    { "<Leader>e", "<CMD>Oil<CR>", desc = "Open Oil" },
  },
}

M.config = function()
  require("oil").setup({
    view_options = {
      show_hidden = true
    }, 
    keymaps = {
      ["g?"] = "actions.show_help",
      ["<CR>"] = "actions.select",
      ["<M-v>"] = { "actions.select", opts = { vertical = true }, desc = "Open the entry in a vertical split" },
      ["<M-h>"] = { "actions.select", opts = { horizontal = true }, desc = "Open the entry in a horizontal split" },
      ["<M-t>"] = { "actions.select", opts = { tab = true }, desc = "Open the entry in new tab" },
      ["<M-p>"] = "actions.preview",
      ["<Leader>q"] = "actions.close",
      ["<M-l>"] = "actions.refresh",
      ["<BS>"] = "actions.parent",
      ["_"] = "actions.open_cwd",
      ["`"] = "actions.cd",
      ["~"] = { "actions.cd", opts = { scope = "tab" }, desc = ":tcd to the current oil directory" },
      ["gs"] = "actions.change_sort",
      ["gx"] = "actions.open_external",
      ["g."] = "actions.toggle_hidden",
      ["g\\"] = "actions.toggle_trash",
    },
    use_default_keymaps = false,
  })
end

return M
