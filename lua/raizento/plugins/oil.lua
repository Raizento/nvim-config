local util = require("raizento.util.fs")

local M = {
  'stevearc/oil.nvim',
  ---@module 'oil'
  ---@type oil.SetupOpts
  opts = {},
  -- Optional dependencies
  dependencies = { "nvim-tree/nvim-web-devicons" }, -- use if prefer nvim-web-devicons
  keys = {
    { "<Leader>e", "<CMD>Oil<CR>", desc = "open Oil" },
  },
}

M.config = function()
  require("oil").setup({
    default_file_explorer = true,
    columns = {
      "icon"
    },
    prompt_save_on_select_new_entry = true,
    lsp_file_methods = {
      enabled = true,
      timeout_ms = 1000,
      autosave_changes = false,
    },
    constrain_cursor = "name",
    watch_for_changes = true,
    keymaps = {
      ["g?"] = "actions.show_help",
      ["<CR>"] = "actions.select",
      ["<M-v>"] = { "actions.select", opts = { vertical = true }, desc = "open the entry in a vertical split" },
      ["<M-h>"] = { "actions.select", opts = { horizontal = true }, desc = "open the entry in a horizontal split" },
      ["<M-t>"] = { "actions.select", opts = { tab = true }, desc = "open the entry in new tab" },
      ["<M-p>"] = "actions.preview",
      ["<M-d>"] = "actions.preview_scroll_down",
      ["<M-u>"] = "actions.preview_scroll_up",
      ["<Leader>q"] = M.handle_oil_quit,
      ["<M-l>"] = "actions.refresh",
      ["<BS>"] = "actions.parent",
      ["_"] = "actions.open_cwd",
      ["`"] = "actions.cd",
      ["~"] = { "actions.cd", opts = { scope = "tab" }, desc = ":tcd to the current oil directory" },
      ["gx"] = "actions.open_external",
      ["g."] = "actions.toggle_hidden",
      ["g\\"] = "actions.toggle_trash",
      ["<C-q>"] = "actions.send_to_qflist",
    },
    use_default_keymaps = false,
    view_options = {
      show_hidden = true
    }, 
  })
end

M.handle_oil_quit = function()
  -- See if oil already has a buffer cached
  -- If it does not, Oil was opened right after nvim was started without any file argument
  local is_buffer_cached, bufnr = pcall(vim.api.nvim_win_get_var, 0, "oil_original_buffer")
    
  -- Return to "scratch" buffer if no buffer is cached
  -- If cached buffer still exists, return to it instead
  -- If there was a cached buffer but it does not exist anymore, quit the window
  if (not is_buffer_cached) or util.does_file_exist_for_bufnr(bufnr) then
    require("oil.actions").close.callback()
  else
    vim.cmd.quit()
  end
end
  
return M
