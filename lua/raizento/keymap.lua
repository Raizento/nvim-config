-- Keybindings for autocompletion can be found in cmp.lua 

vim.api.nvim_set_keymap('', '<Space>', '<Nop>', { noremap = true, silent = true })
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

vim.keymap.set('n', '::', 'q:', { noremap = true })
vim.keymap.set('n', '//', 'q/', { noremap = true })
vim.keymap.set('n', '??', 'q?', { noremap = true })

vim.keymap.set('n', '<Leader>w', ':w<CR>', { noremap = true })
vim.keymap.set('n', '<Leader>q', ':q<CR>', { noremap = true })


-- Telescope keybinds
local builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>ff', builtin.find_files, { noremap = true })
vim.keymap.set('n', '<leader>fg', builtin.live_grep, { noremap = true })
vim.keymap.set('n', '<leader>fb', builtin.buffers, { noremap = true })
vim.keymap.set('n', '<leader>fh', builtin.help_tags, { noremap = true })
vim.keymap.set('n', '<leader>ft', builtin.tags, { noremap = true })

-- Neotree
vim.keymap.set('n', '<leader>nt', '<cmd>Neotree toggle<cr>', { noremap = true })

-- LazyGit
vim.keymap.set('n', '<leader>gg', '<cmd>LazyGit<cr>', { noremap = true })
