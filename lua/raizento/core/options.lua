-- Vim options
vim.g.mapleader = " "
vim.g.maplocalleader = [[\]]

vim.o.number = true
vim.o.relativenumber = true
vim.o.numberwidth = 4

vim.o.autoindent = true
vim.o.smartindent = true
vim.o.cindent = true
vim.o.shiftwidth = 4
vim.o.tabstop = 4
vim.o.expandtab = true
vim.o.smarttab = true

vim.o.mouse = "a"

vim.o.foldcolumn = "6"

vim.o.incsearch = true
vim.o.ignorecase = true

vim.o.backspace = "indent,eol,start"
vim.o.matchpairs = "(:),{:},[:],<:>"

vim.o.magic = true -- plugins may break if this option is turned off

vim.o.ruler = true

vim.o.undofile = true

vim.o.splitright = true
vim.o.splitbelow = true

vim.o.scrolloff = 4
vim.o.sidescrolloff = 8

vim.o.wrap = false

vim.o.termguicolors = true

vim.o.title = true

vim.o.showmode = false -- Lualine takes care of indicating the mode

vim.o.foldlevelstart = 99

vim.o.updatetime = 100 -- TreeSitter updates definition highlighting every {updatetime} ms

vim.o.virtualedit = "block"

vim.o.inccommand = "split"
vim.o.cmdwinheight = 16
