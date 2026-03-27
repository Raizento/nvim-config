local Plugin = require("raizento.plugins.plugin")

---@type Plugin
local M = {
  url = "https://github.com/hrsh7th/nvim-cmp",
  dependencies = {
    "https://github.com/L3MON4D3/LuaSnip",
    { url = "https://github.com/hrsh7th/cmp-nvim-lsp", name = "cmp_nvim_lsp" },
    { url = "https://github.com/hrsh7th/cmp-buffer", name = "cmp_buffer" },
    "https://github.com/rafamadriz/friendly-snippets",
    { url = "https://github.com/hrsh7th/cmp-path", name = "cmp_path" },
    { url = "https://github.com/hrsh7th/cmp-cmdline", name = "cmp_cmdline" },
    { url = "https://github.com/hrsh7th/cmp-nvim-lsp-signature-help", name = "cmp_nvim_lsp_signature_help" },
    { url = "https://github.com/delphinus/cmp-ctags", name = "cmp_ctags" },
    { url = "https://github.com/hrsh7th/cmp-nvim-lua", name = "cmp_nvim_lua" },
    "https://github.com/saadparwaiz1/cmp_luasnip",
  },
}

M.setup = function()
  local cmp = require("cmp")
  local luasnip = require("luasnip")

  cmp.setup({
    snippet = {
      expand = function(args)
        luasnip.lsp_expand(args.body)
      end,
    },
    window = {},
    sources = cmp.config.sources({
      { name = "nvim_lsp" },
      { name = "nvim_lsp_signature_help" },
      { name = "lazydev" },
      { name = "luasnip" },
      { name = "nvim_lua" },
      { name = "buffer" },
      { name = "path" },
    }),

    mapping = cmp.mapping.preset.insert({
      ["<C-b>"] = cmp.mapping.scroll_docs(-4),
      ["<C-f>"] = cmp.mapping.scroll_docs(4),
      ["<C-Space>"] = cmp.mapping.complete(),
      ["<C-e>"] = cmp.mapping.abort(),
      ["<C-y>"] = cmp.mapping(function(fallback)
        if not cmp.visible() then
          fallback()
          return
        end

        -- Automatically select first entry if there is no selected entry yet
        -- First hit is often the one you want; makes completing that a bit easier
        if cmp.get_selected_entry() == nil then
          cmp.select_next_item()
        end

        cmp.confirm()
      end, { "i", "s" }),
      ["<Tab>"] = cmp.mapping(function(fallback)
        if luasnip.expand_or_jumpable() then
          luasnip.expand_or_jump()
        else
          fallback()
        end
      end, { "i", "s" }),
      ["<S-Tab>"] = cmp.mapping(function(fallback)
        if luasnip.jumpable(-1) then
          luasnip.jump(-1)
        else
          fallback()
        end
      end, { "i", "s" }),
    }),
  })

  -- Completions for / and ? search based on current buffer
  cmp.setup.cmdline({ "/", "?" }, {
    mapping = cmp.mapping.preset.cmdline(),
    sources = {
      { name = "buffer" },
    },
  })

  -- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
  cmp.setup.cmdline(":", {
    mapping = cmp.mapping.preset.cmdline(),
    sources = cmp.config.sources({
      { name = "path" },
    }, {
      {
        name = "cmdline",
        -- Limit lagging on WSL
        -- If inside a WSL Distro, only start completing after 3 characters
        -- Lessens the effects the big WSL path (Windows path + Distro path) has on the synchronous search
        keyword_length = os.getenv("WSL_DISTRO_NAME") ~= nil and 3 or 0,
      },
    }),
  })

  function _G.leave_snippet()
    if
      ---@diagnostic disable-next-line: undefined-field
      ((vim.v.event.old_mode == "s" and vim.v.event.new_mode == "n") or vim.v.event.old_mode == "i")
      and require("luasnip").session.current_nodes[vim.api.nvim_get_current_buf()]
      and not require("luasnip").session.jump_active
    then
      require("luasnip").unlink_current()
    end
  end

  -- stop snippets when you leave insert mode
  vim.api.nvim_command([[ autocmd ModeChanged * lua leave_snippet() ]])
end

return Plugin:new(M)
