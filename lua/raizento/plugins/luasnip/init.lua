local Plugin = require("raizento.plugins.plugin")

---@type Plugin
local M = {
  url = "https://github.com/L3MON4D3/LuaSnip",
  dependencies = {
    "https://github.com/rafamadriz/friendly-snippets",
  },
  setup = function()
    local ls = require("luasnip")
    ls.config.set_config({
      history = true,
      updateevents = "TextChanged,TextChangedI",
    })

    require("luasnip.loaders.from_vscode").lazy_load()

    local java_snippets = require("raizento.plugins.luasnip.java_snippets")

    ls.add_snippets("java", java_snippets)
  end,
  keys = {
    {
      { "i", "s" },
      "<C-k>",
      function()
        local ls = require("luasnip")
        if ls.expand_or_jumpable() then
          ls.jump(1)
        end
      end,
    },
    {
      { "i", "s" },
      "<C-j>",
      function()
        local ls = require("luasnip")
        if ls.jumpable(-1) then
          ls.jump(-1)
        end
      end,
    },
    {
      { "i" },
      "<C-l>",
      function()
        local ls = require("luasnip")
        if ls.choice_active() then
          ls.change_choice(1)
        end
      end,
    },
  },
}

return Plugin:new(M)
