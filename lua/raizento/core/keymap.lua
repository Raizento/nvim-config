-- Easier access to search commands
vim.keymap.set("n", "::", "q:", { noremap = true, silent = true, desc = "command history" })
vim.keymap.set("n", "//", "q/", { noremap = true, silent = true, desc = "fwd search history" })
vim.keymap.set("n", "??", "q?", { noremap = true, silent = true, desc = "bwd serach history" })

-- When pasting over something in visual mode, don't delete content of standard buffer
vim.keymap.set("x", "p", [["_dP]])

-- Stay in indent mode
vim.keymap.set("v", "<", "<gv")
vim.keymap.set("v", ">", ">gv")

-- Easier jumps to beginning/ending of line
vim.keymap.set({ "n", "o", "x" }, "<s-h>", "^")
vim.keymap.set({ "n", "o", "x" }, "<s-l>", "g_")

vim.keymap.set("n", "<Leader>w", ":w<CR>", { noremap = true, silent = true, desc = "write file" })
vim.keymap.set("n", "<Leader>q", ":q<CR>", { noremap = true, silent = true, desc = "quit" })

-- Window splitting
vim.keymap.set("n", "<Leader>v", "<C-w>v", { noremap = true, silent = true, desc = "split vertically" })
vim.keymap.set("n", "<Leader>s", "<C-w>s", { noremap = true, silent = true, desc = "split horizontally" })
vim.keymap.set("n", "<Leader>c", "<C-w>c", { noremap = true, silent = true, desc = "close window" })

-- Easier copying and pasting to and from clipboard
vim.keymap.set({ "n", "v" }, "<Leader>y", [["+y]], { noremap = true, silent = true, desc = "copy to clipboard" })
vim.keymap.set({ "n", "v" }, "<Leader>p", [["+p]], { noremap = true, silent = true, desc = "paste from clipboard" })
vim.keymap.set({ "n", "v" }, "<Leader>P", [["+P]], { noremap = true, silent = true, desc = "paste from clipboard" })

-- Place semicolon at the end of a line
vim.keymap.set("n", "<Leader>;", [[mmA;<Esc>`m]], { noremap = true, silent = true, desc = "Place ; at end of line" })
