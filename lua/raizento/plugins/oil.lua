local Plugin = require("raizento.plugins.plugin")

---@type Plugin
local M = {
    name = "oil",
    url = "https://github.com/stevearc/oil.nvim",
    dependencies = {
        "https://github.com/nvim-tree/nvim-web-devicons",
    },
    ---@module 'oil'
    ---@type oil.SetupOpts
    opts = {
        default_file_explorer = true,
        columns = {
            "icon",
        },
        prompt_save_on_select_new_entry = true,
        watch_for_changes = true,
        lsp_file_methods = {
          enabled = true,
          timeout_ms = 1000,
          autosave_changes = false,
        },
        constrain_cursor = "name",
        view_options = {
          show_hidden = true,
        },
    },
    keys = {
        { "n", "<Leader>e", "<CMD>Oil<CR>", { desc = "open Oil"} },
    }
}

return Plugin:new(M)
