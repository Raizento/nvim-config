-- Utilizes code from https://yeripratama.com/blog/customizing-nvim-telescope/
-- Keep track of current options status
local temp_showtabline
local temp_laststatus
local temp_ruler
local temp_cmdheight

-- Save status for options and disable them
function _G.global_telescope_find_pre()
    temp_showtabline = vim.o.showtabline
    temp_laststatus = vim.o.laststatus
    temp_ruler = vim.o.ruler
    temp_cmdheight = vim.o.cmdheight

    vim.o.ruler = false
    vim.o.showtabline = 0
    vim.o.laststatus = 0
    vim.o.cmdheight = 0
end

-- Recover status from global_telescope_find_pre()
function _G.global_telescope_leave_prompt()
    vim.o.laststatus = temp_laststatus
    vim.o.showtabline = temp_showtabline
    vim.o.ruler = temp_ruler
    vim.o.cmdheight = temp_cmdheight
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


-- TODO implement LSP bindings
local M = {
  "nvim-telescope/telescope.nvim",
  dependencies = {
    "nvim-lua/plenary.nvim",
  },
  keys = {
    { "<Leader>ff", "<CMD>lua require('telescope.builtin').find_files({hidden = true})<CR>", desc = "find files" },
    { "<Leader>fg", "<CMD>Telescope live_grep<CR>", desc = "live grep" },
    { "<Leader>fb", "<CMD>Telescope buffers<CR>", desc = "buffers" },
    { "<Leader>fh", "<CMD>Telescope help_tags<CR>", desc = "help tags" },
    { "<Leader>ft", "<CMD>Telescope tags<CR>", desc = "tags" },
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
                ["<C-Down>"] = require('telescope.actions').cycle_history_next,
                ["<C-Up>"] = require('telescope.actions').cycle_history_prev,
            }
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
            "--smart-case"
        },
    }

  })
end

return M
