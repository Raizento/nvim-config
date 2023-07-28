require("nvim-treesitter.install").prefer_git = true
require "nvim-treesitter.configs".setup {
    ensure_installed = { "c", "lua", "vim", "vimdoc", "query", "rust", "gitignore", "json", "yaml", "toml", "regex", "groovy", "java" },

    highlight = {
        enable = true,
    }
}

vim.opt.foldmethod      = "expr"
vim.opt.foldexpr        = "nvim_treesitter#foldexpr()"
