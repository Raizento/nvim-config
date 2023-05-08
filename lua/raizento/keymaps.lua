opts = { noremap = true, silent = true }

local keymap = vim.api.nvim_set_keymap


-- Remap space as leader key
keymap("", "<Space>", "<Nop>", opts)
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Abbreviations
-- <C-x>    = Press Control and key simultaneously
-- <S-x>    = Press Shift   and key simultaneously
-- <A-x>    = Press Alt     and key simultaneously
-- <cr>     = Carriage return/return key

-- Modes
--  normal mode         = "n"
--  insert mode         = "i"
--  visual mode         = "v"
--  visual block mode   = "x"
--  term mode           = "t"
--  command mode        = "c"

-- Normal mode --
-- Window navigation from <C-w>h/j/k/l to <C-h/j/k/l>
-- TODO currently commented out due to conflicts with netrw keymap
-- keymap("n", "<C-h>", "<C-w>h", opts)
-- keymap("n", "<C-j>", "<C-w>j", opts)
-- keymap("n", "<C-k>", "<C-w>k", opts)
-- keymap("n", "<C-l>", "<C-w>l", opts)

-- TODO change command to function 
-- Focus nvim-tree if not focused; otherwise, close nvim-tree
local nvim_tree_status_ok, nvim_tree = pcall(require, "nvim-tree")
if not nvim_tree_status_ok then
    return
end

--keymap("n", "<leader>e", ":NvimTreeToggle<CR>", opts)
