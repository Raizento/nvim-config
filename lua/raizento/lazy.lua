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

-- TODO This is only needed for functional tests currently; need to have a look at how I can move this out of the main part
vim.api.nvim_create_autocmd("User", {
  pattern = "LazyDone",
  callback = function(_)
    require("raizento.config").is_lazy_done = true
  end,
})

require("lazy").setup({
  spec = LAZY_PLUGIN_SPEC,
})
