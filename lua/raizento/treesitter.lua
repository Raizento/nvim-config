local treesitter_status, treesitter = pcall(require, "nvim-treesitter.configs")
if not treesitter_status then
    print("Could not load treesitter!")
    return
end

local whichkey = require "which-key"

treesitter.setup {
    ensure_installed = { "vim", "vimdoc", "yaml", "toml", "regex", "json", "json5", "html", "gitignore", "gitcommit",
        "gitattributes", "csv", "comment", "bash", },
    auto_install = true,
    highlight = {
        enable = true,
    },
    refactor = {
        highlight_definitions = {
            enable = true,
            clear_on_cursor_move = false,
        },
        smart_rename = {
            enable = true,
            -- TODO use whichkey for mappings
            keymaps = {
                smart_rename = "<Leader>tr"
            }
        },
    },
}
