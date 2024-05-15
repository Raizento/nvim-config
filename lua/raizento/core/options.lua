-- Vim options
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.numberwidth = 4

vim.opt.autoindent = true
vim.opt.smartindent = true
vim.opt.cindent = true
vim.opt.shiftwidth = 4
vim.opt.tabstop = 4
vim.opt.expandtab = true
vim.opt.smarttab = true

vim.opt.mouse = "a"

vim.opt.foldcolumn = "6"

vim.opt.incsearch = true
vim.opt.ignorecase = true

vim.opt.backspace = "indent,eol,start"
vim.opt.matchpairs = "(:),{:},[:],<:>"

vim.opt.magic = true -- plugins may break if this option is turned off

vim.opt.ruler = true

vim.opt.undofile = true

vim.opt.splitright = true
vim.opt.splitbelow = true

vim.opt.scrolloff = 4
vim.opt.sidescrolloff = 8

vim.opt.wrap = false

vim.opt.termguicolors = true

vim.opt.title = true

vim.opt.showmode = false -- Lualine takes care of indicating the mode

vim.opt.foldlevelstart = 99

vim.opt.updatetime = 100 -- TreeSitter updates definition highlighting every {updatetime} ms

vim.opt.virtualedit = "block"

vim.opt.inccommand = "split"
vim.opt.cmdwinheight = 16
