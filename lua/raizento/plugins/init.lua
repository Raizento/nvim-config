local util = require("raizento.plugins.util")

-- First need to add all of them, then require them
local plugins = {
  require("raizento.plugins.treesitter"),
  require("raizento.plugins.oil"),
  require("raizento.plugins.tmux-navigation"),
  require("raizento.plugins.telescope"),
  require("raizento.plugins.autopairs"),
  require("raizento.plugins.gitsigns"),
  require("raizento.plugins.onedark"),
  require("raizento.plugins.luasnip"),
  require("raizento.plugins.cmp"),
  require("raizento.plugins.indent-blankline"),
  require("raizento.plugins.lualine"),
  require("raizento.lsp.mason"),
  require("raizento.lsp.plugins.jdtls"),
  require("raizento.lsp.plugins.lazydev"),
  require("raizento.lsp.plugins.lspconfig"),
}

local order = util.topological_order(plugins)

-- Set up hooks before first call to vim.pack.add. Autocommands won't work if
-- not added before first call to vim.pack.add when installing from lockfile;
-- see :h vim.pack-events
vim.iter(order):each(function(plugin)
  plugin:setup_hooks()
end)

-- Adding all plugins at once is the approach vim.pack.add is designed around; see
-- https://echasnovski.com/blog/2026-03-13-a-guide-to-vim-pack.html#single-vim-pack-add
local plugin_urls = vim
  .iter(order)
  :map(function(plugin)
    return plugin.url
  end)
  :totable()
vim.pack.add(plugin_urls)

vim.iter(order):each(function(plugin)
  plugin:enable()
end)
