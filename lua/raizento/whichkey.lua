vim.opt.timeout = true
vim.opt.timeoutlen = 500
local wk = require("which-key")

vim.api.nvim_set_keymap('', '<Space>', '<Nop>', { noremap = true, silent = true })
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

wk.register({
    f = {
        name = "telescope",
        f = { "<cmd>Telescope find_files<cr>", "Find File" },
        g = { "<cmd>Telescope live_grep<cr>", "Search" },
        b = { "<cmd>Telescope buffers<cr>", "Buffers" },
        h = { "<cmd>Telescope help_tags<cr>", "Help Tags" },
        t = { "<cmd>Telescope tags<cr>", "Search Tags" },
    },

    w = { "<cmd>w<cr>", "Write" },
    q = { "<cmd>q<cr>", "Quit"},

    g = {
        name = "git",
        g = { "<cmd>LazyGit<cr>", "Open LaziGit" },
    },

    n = {
        name = "neotree",
        t = { "<cmd>Neotree toggle<cr>", "Toggle" },
        f = { "<cmd>Neotree focus<cr>", "Focus"},
    },

    w = {
        name = "window",
        h = { "<C-w>h", "Move to left window" },
        l = { "<C-w>l", "Move to right window" },
        k = { "<C-w>k", "Move to upper window" },
        j = { "<C-w>j", "Move to lower window" },
    },

}, { prefix = "<leader>" })

wk.register({
    ["//"] = { "q/", "fwd search history" },
    ["??"] = { "q?", "bwd search history" },
    ["::"] = { "q:", "Command history" },
})
