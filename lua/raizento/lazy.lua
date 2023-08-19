local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.runtimepath:prepend(lazypath)

require("lazy").setup({
  "folke/which-key.nvim",
  { "ms-jpq/coq_nvim", branch = "coq" },
  { "ms-jpq/coq.artifacts", branch = "artifacts" },
  { "ms-jpq/coq.thirdparty", branch = "3p" },
  "neovim/nvim-lspconfig",
  "navarasu/onedark.nvim",
})


