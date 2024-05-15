local M = {
  "nvim-treesitter/nvim-treesitter",
  build = ":TSUpdate",
  dependencies = { "nvim-treesitter/nvim-treesitter-refactor" },
}

M.config = function()
  require("nvim-treesitter.configs").setup({
    ensure_installed = {
      "lua",
      "vim",
      "vimdoc",
      "query",
    },
    auto_install = true,
    ignore_install = {
      "latex"
    },
    highlight = {
      enable = true,
      disable = { "latex" },
      additional_vim_regex_highlighting = { "latex", "markdown" },
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
      smart_rename = {
        enable = true,
        keymaps = {
          smart_rename = "<Leader>tr",
        },
      },
    },
  })

  vim.opt.foldmethod = "expr"
  vim.opt.foldexpr = "nvim_treesitter#foldexpr()"

  vim.api.nvim_create_autocmd({ "BufEnter", "BufWinEnter", "InsertLeave" }, {
    callback = function()
      vim.opt.foldmethod = "expr"
      vim.opt.foldexpr = "nvim_treesitter#foldexpr()"
    end,
    desc = "Folding with TreeSitter",
  })
end

return M
