local M = {
  'stevearc/oil.nvim',
  ---@module 'oil'
  ---@type oil.SetupOpts
  opts = {},
  -- Optional dependencies
  dependencies = { "nvim-tree/nvim-web-devicons" }, -- use if prefer nvim-web-devicons
}

M.config = function()
  require("oil").setup({
    view_options = {
      show_hidden = true
    }, 
    keymaps = {
      ["g?"] = "actions.show_help",
      ["<CR>"] = "actions.select",
      -- TODO Look for better mappings for these
      --["<C-s>"] = { "actions.select", opts = { vertical = true }, desc = "Open the entry in a vertical split" },
      --["<C-h>"] = { "actions.select", opts = { horizontal = true }, desc = "Open the entry in a horizontal split" },
      ["<C-t>"] = { "actions.select", opts = { tab = true }, desc = "Open the entry in new tab" },
      ["<C-p>"] = "actions.preview",
      ["<C-c>"] = "actions.close",
      ["<M-l>"] = "actions.refresh",
      ["<BS>"] = "actions.parent",
      ["_"] = "actions.open_cwd",
      ["`"] = "actions.cd",
      -- TODO Mapping to change back into directory in which NVIM was opened
      ["="] = { function() 
                  require("oil.actions").cd.callback()
                end, 
                desc = "Open Oil in the directory nvim was started in" },
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
