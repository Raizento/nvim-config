local M = {
  "nvim-treesitter/nvim-treesitter",
  build = ":TSUpdate",
  dependencies = { "nvim-treesitter/nvim-treesitter-refactor", "nvim-treesitter/nvim-treesitter-textobjects" },
  lazy = false, -- lazy loading is not supported
  branch = "master",
}

M.textobjects = {
  select = {
    enable = true,
    lookahead = true,
    keymaps = {
      ["am"] = { query = "@function.outer", desc = "outer function" },
      ["im"] = { query = "@function.inner", desc = "inner function" },
      ["ac"] = { query = "@class.outer", desc = "outer class" },
      ["ic"] = { query = "@class.inner", desc = "inner class" },
      ["ar"] = { query = "@return.outer", desc = "outer return" },
      ["ir"] = { query = "@return.inner", desc = "inner return" },
      ["ab"] = { query = "@block.outer", desc = "outer block" },
      ["ib"] = { query = "@block.inner", desc = "inner block" },
      ["a/"] = { query = "@comment.outer", desc = "outer comment" },
      ["i/"] = { query = "@comment.inner", desc = "inner comment" },
    },
  },
  move = {
    enable = true,
    set_jumps = true,
    goto_next_start = {
      ["]m"] = { query = "@function.outer", desc = "next function start" },
      ["]c"] = { query = "@class.outer", desc = "next class start" },
      ["]b"] = { query = "@block.outer", desc = "next block start" },
    },
    goto_next_end = {
      ["]M"] = { query = "@function.outer", desc = "next function end" },
      ["]C"] = { query = "@class.outer", desc = "next class end" },
      ["]B"] = { query = "@block.outer", desc = "next block end" },
    },
    goto_previous_start = {
      ["[m"] = { query = "@function.outer", desc = "previous function start" },
      ["[c"] = { query = "@class.outer", desc = "previous class start" },
      ["[b"] = { query = "@block.outer", desc = "previous block start" },
    },
    goto_previous_end = {
      ["[M"] = { query = "@function.outer", desc = "previous function end" },
      ["[C"] = { query = "@class.outer", desc = "previous class end" },
      ["[B"] = { query = "@block.outer", desc = "previous block end" },
    },
  },
}

M.opts = {
  ensure_installed = {
    "lua",
    "vim",
    "vimdoc",
    "query",
  },
  -- TODO this is only temporary; need to find a way in which I can properly determine whether or not a parser is fully installed
  sync_install = require("raizento.config").is_test,
  auto_install = true,
  ignore_install = {
    "latex",
  },
  highlight = {
    enable = true,
    disable = { "latex" },
    additional_vim_regex_highlighting = false,
  },
  incremental_selection = {
    enable = true,
    keymaps = {
      init_selection = "gnn",
      node_incremental = "grn",
      scope_incremental = "grc",
      node_decremental = "grm",
    },
  },
  indent = {
    enable = true,
  },
  refactor = {
    highlight_definitions = {
      enable = true,
      clear_on_cursor_move = false,
    },
  },
  textobjects = M.textobjects,
}

M.config = function()
  require("nvim-treesitter.configs").setup(M.opts)

  vim.opt.foldmethod = "expr"
  vim.opt.foldexpr = "v:lua.vim.treesitter.foldexpr()"

  vim.api.nvim_create_autocmd({ "BufEnter", "BufWinEnter", "InsertLeave", "TextChanged" }, {
    callback = function()
      vim.opt.foldmethod = "expr"
      vim.opt.foldexpr = "v:lua.vim.treesitter.foldexpr()"
    end,
    desc = "Folding with TreeSitter",
  })
end

return M
