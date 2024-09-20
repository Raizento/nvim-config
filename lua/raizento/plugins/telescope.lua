-- Utilizes code from https://yeripratama.com/blog/customizing-nvim-telescope/
-- Keep track of current option status
local temp_showtabline
local temp_laststatus

-- Save status for showtabline and laststatus and disable both of them
function _G.global_telescope_find_pre()
    temp_showtabline = vim.o.showtabline
    temp_laststatus = vim.o.laststatus
    vim.o.showtabline = 0
    vim.o.laststatus = 0
end

-- Recover status from global_telescope_find_pre()
function _G.global_telescope_leave_prompt()
    vim.o.laststatus = temp_laststatus
    vim.o.showtabline = tem.showtabline
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

local M = {
  "nvim-telescope/telescope.nvim",
  dependencies = {
    "nvim-lua/plenary.nvim",
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
  },
}

M.config = function()
  local telescope = require("telescope")
  telescope.setup({
    defaults = {
        layout_strategy = "horizontal",
        layout_config = {
            width = { padding = 0 },
            height = { padding = 0 },
            preview_width = 0.6,
        },
        -- Empty borderchars will still keep the UI title centered
        borderchars = { " ", " ", " ", " ", " ", " ", " ", " " },
        path_display = { "filename_first" },
        
    }

  })
end

return M
