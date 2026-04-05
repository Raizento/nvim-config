vim.pack.add({ "https://github.com/Raizento/vpaw" })

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
  require("raizento.lsp.plugins.java"),
  require("raizento.lsp.plugins.lazydev"),
  require("raizento.lsp.plugins.lspconfig"),
}

require("vpaw").install(plugins)
