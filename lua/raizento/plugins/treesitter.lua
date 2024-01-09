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
        highlight = {
            enable = true,
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
            enable = true
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
end

return M
