local Plugin = require("raizento.plugins.plugin")

-- Utilizes code from https://yeripratama.com/blog/customizing-nvim-telescope/
-- Keep track of current options status
local temp_showtabline
local temp_laststatus
local temp_ruler
local temp_cmdheight

-- Save status for options and disable them
function _G.global_telescope_find_pre()
  temp_showtabline = vim.opt.showtabline
  temp_laststatus = vim.opt.laststatus
  temp_ruler = vim.opt.ruler
  temp_cmdheight = vim.opt.cmdheight

  vim.opt.ruler = false
  vim.opt.showtabline = 0
  vim.opt.laststatus = 0
  vim.opt.cmdheight = 0
end

-- Recover status from global_telescope_find_pre()
function _G.global_telescope_leave_prompt()
  vim.opt.laststatus = temp_laststatus
  vim.opt.showtabline = temp_showtabline
  vim.opt.ruler = temp_ruler
  vim.opt.cmdheight = temp_cmdheight
end

-- Make Telescope UI fullscreen on opening it
-- Remove status and tabline when opening and restore when leaving Telescope prompt
vim.cmd([[
    augroup TelescopeFullscreen
        autocmd!
        autocmd User TelescopeFindPre lua global_telescope_find_pre()
        autocmd FileType TelescopePrompt autocmd BufLeave <buffer> lua global_telescope_leave_prompt()
    augroup END
]])

_G.is_git_dir = function()
    local result = vim.system({"git", "rev-parse"}, { text = true }):wait()
    if result.code == 0 then
        return true
    end

    return false
end


-- TODO implement LSP bindings
---@type Plugin
local M = {
  url = "https://github.com/nvim-telescope/telescope.nvim",
  dependencies = {
    "https://github.com/nvim-lua/plenary.nvim",
  },
  keys = {
    {
      "n",
      "<Leader>ff",
      function()
          if not is_git_dir() then
              vim.print("Not a git dir; can't use git_files picker")
              return
          end
          vim.cmd([[Telescope git_files]])
      end,
      { desc = "find git tracked files" },
    },
    { "n", "<Leader>fF", "<CMD>lua require('telescope.builtin').find_files({hidden = true})<CR>", { desc = "find all files" } },
    { "n", "<Leader>fg", "<CMD>Telescope live_grep<CR>", { desc = "live grep" } },
    { "n", "<Leader>fb", "<CMD>Telescope buffers<CR>", { desc = "buffers" } },
    { "n", "<Leader>fh", "<CMD>Telescope help_tags<CR>", { desc = "help tags" } },
    { "n", "<Leader>fc", "<CMD>Telescope commands<CR>", { desc = "commands" } },
    {
      "n", "<Leader>fl",
      "<CMD>lua vim.diagnostic.setloclist({ open = false })<CR><CMD>Telescope loclist<CR>",
      { desc = "loclist" },
    },
    { "n", "<Leader>fo", "<CMD>Telescope vim_options<CR>", { desc = "vim options"} },
  },
  opts = {
    defaults = {
      layout_strategy = "horizontal",
      -- Use fullscreen for Telescope; preview uses 60%, results/prompt 40%
      layout_config = {
        width = { padding = 0 },
        height = { padding = 0 },
        preview_width = 0.6,
      },

      -- Empty borderchars will still keep the UI titles centered
      borderchars = { " ", " ", " ", " ", " ", " ", " ", " " },

      path_display = { "filename_first" },

      mappings = {
        i = {
          -- TODO don't really like these mappings; look for better ones
          ["<C-Down>"] = "cycle_history_next",
          ["<C-Up>"] = "cycle_history_prev",
          ["<C-Q>"] = function()
            local bufnr = vim.fn.bufnr()
            local telescope = require("telescope.actions")
            telescope.smart_send_to_qflist(bufnr)
            telescope.open_qflist(bufnr)
          end,
          ["<C-L>"] = function()
            local bufnr = vim.fn.bufnr()
            local telescope = require("telescope.actions")
            telescope.smart_send_to_loclist(bufnr)
            telescope.open_loclist(bufnr)
          end,
        },
      },

      vimgrep_arguments = {
        "rg",
        "--color=never",
        -- Also search through hidden files and directories when using rg
        "--hidden",
        "--no-heading",
        "--with-filename",
        "--line-number",
        "--column",
        "--smart-case",
      },
    },
  },
}

M.description_grep_string = function()
  return "search for " .. vim.fn.expand("<cword>")
end


M.setup = function()
  require("telescope").setup(M.opts)
  -- local wk = require("which-key")
  -- wk.add({
  --   {
  --     "<Leader>f*",
  --     "<CMD>lua require('telescope.builtin').grep_string({})<CR>",
  --     desc = M.description_grep_string,
  --   },
  -- })
end

return Plugin:new(M)
